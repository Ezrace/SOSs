import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

const modelId = 'nvidia/nemotron-3.5-super-vl';
const allowedAdjustments = <String>[
  'dim_lights',
  'warm_lights',
  'lower_media_volume',
  'play_brown_noise',
  'pause_audio',
  'give_space',
  'stay_quiet',
  'offer_preferred_item',
  'no_change',
];

Response jsonResponse(int status, Map<String, dynamic> data) => Response(
  status,
  body: jsonEncode(data),
  headers: {'content-type': 'application/json; charset=utf-8'},
);

final router = Router()
  ..get(
    '/health',
    (Request request) => jsonResponse(200, {
      'status': 'ok',
      'service': 'SOSs AI backend',
      'model': modelId,
    }),
  )
  ..post('/analyse', _analyse);

Future<Response> _analyse(Request request) async {
  final apiKey = Platform.environment['OPENROUTER_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    return jsonResponse(500, {
      'error': 'Configure OPENROUTER_API_KEY on the backend.',
    });
  }

  final dynamic decoded;
  try {
    decoded = jsonDecode(await request.readAsString());
  } on FormatException {
    return jsonResponse(400, {'error': 'Invalid JSON request.'});
  }
  if (decoded is! Map<String, dynamic>) {
    return jsonResponse(400, {'error': 'Request must be a JSON object.'});
  }

  final note = decoded['note'];
  final selectedNeed = decoded['selectedNeed'];
  final preferences = decoded['preferences'];
  if (note is! String ||
      selectedNeed is! String ||
      preferences is! Map<String, dynamic> ||
      note.trim().isEmpty ||
      note.length > 2000 ||
      selectedNeed.trim().isEmpty ||
      selectedNeed.length > 100) {
    return jsonResponse(400, {'error': 'Invalid or incomplete input.'});
  }

  try {
    final response = await http
        .post(
          Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $apiKey',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode({
            'model': modelId,
            'temperature': 0.2,
            // Reserve enough output for the model's reasoning and final JSON.
            'max_tokens': 1600,
            'reasoning': {'effort': 'low'},
            'stream': false,
            'messages': [
              {
                'role': 'system',
                'content':
                    '''
You are the SOSs sensory-support information assistant.
Summarise only supplied information. This is not a diagnostic or treatment system.
Never diagnose, invent context, or claim to know unreported feelings.
Consider preferences, suggest only allowed actions, and use no_change when uncertain.
Suggestions are for caregiver review. Do not issue device commands.
Allowed actions: ${allowedAdjustments.join(', ')}
Return only the requested JSON object.
''',
              },
              {
                'role': 'user',
                'content': jsonEncode({
                  'user_or_caregiver_note': note.trim(),
                  'selected_need': selectedNeed.trim(),
                  'pre_agreed_preferences': preferences,
                }),
              },
            ],
            'response_format': {
              'type': 'json_schema',
              'json_schema': {
                'name': 'sos_support_analysis',
                'strict': true,
                'schema': {
                  'type': 'object',
                  'properties': {
                    'summary': {'type': 'string'},
                    'reported_triggers': {
                      'type': 'array',
                      'items': {'type': 'string'},
                    },
                    'context_summary': {'type': 'string'},
                    'suggested_adjustments': {
                      'type': 'array',
                      'items': {'type': 'string', 'enum': allowedAdjustments},
                    },
                    'caregiver_message': {'type': 'string'},
                    'uncertainty': {'type': 'string'},
                  },
                  'required': [
                    'summary',
                    'reported_triggers',
                    'context_summary',
                    'suggested_adjustments',
                    'caregiver_message',
                    'uncertainty',
                  ],
                  'additionalProperties': false,
                },
              },
            },
          }),
        )
        .timeout(const Duration(seconds: 45));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      stderr.writeln('OpenRouter returned HTTP ${response.statusCode}.');
      return jsonResponse(502, {'error': 'AI analysis is unavailable.'});
    }

    final responseJson = jsonDecode(response.body);
    if (responseJson is Map<String, dynamic> &&
        responseJson['error'] is Map<String, dynamic>) {
      final providerError = responseJson['error'] as Map<String, dynamic>;
      final message = providerError['message']?.toString();
      return jsonResponse(502, {
        'error': message == null || message.isEmpty
            ? 'The AI provider returned an error.'
            : 'The AI provider returned an error: $message',
      });
    }
    final choices = responseJson is Map<String, dynamic>
        ? responseJson['choices']
        : null;
    final firstChoice = choices is List && choices.isNotEmpty
        ? choices.first
        : null;
    final message = firstChoice is Map<String, dynamic>
        ? firstChoice['message']
        : null;
    final rawContent = message is Map<String, dynamic>
        ? message['content']
        : null;
    final content = switch (rawContent) {
      String value => value,
      List<dynamic> parts =>
        parts
            .whereType<Map<String, dynamic>>()
            .map((part) => part['text'])
            .whereType<String>()
            .join(),
      _ => null,
    };
    if (content == null || content.isEmpty) {
      final finishReason = firstChoice is Map<String, dynamic>
          ? firstChoice['finish_reason']?.toString()
          : null;
      final messageKeys = message is Map<String, dynamic>
          ? message.keys.join(', ')
          : 'none';
      stderr.writeln(
        'OpenRouter returned no text content. '
        'finish_reason=$finishReason message_keys=$messageKeys',
      );
      return jsonResponse(502, {
        'error': 'The AI returned no text content.',
        'detail': finishReason == null
            ? 'The provider returned an empty message.'
            : 'The provider stopped with finish_reason=$finishReason.',
      });
    }

    final result = jsonDecode(content);
    if (result is! Map<String, dynamic>) {
      return jsonResponse(502, {
        'error': 'The AI returned invalid structured data.',
      });
    }
    final actions = result['suggested_adjustments'];
    if (actions is! List ||
        !actions.every(
          (action) => action is String && allowedAdjustments.contains(action),
        )) {
      return jsonResponse(502, {
        'error': 'The AI returned an unsupported action.',
      });
    }
    return jsonResponse(200, result);
  } on TimeoutException {
    return jsonResponse(504, {'error': 'AI analysis timed out.'});
  } on SocketException {
    return jsonResponse(502, {'error': 'Could not connect to OpenRouter.'});
  } on FormatException {
    return jsonResponse(502, {'error': 'OpenRouter returned invalid data.'});
  } catch (error) {
    stderr.writeln('SOSs AI request failed: ${error.runtimeType}');
    return jsonResponse(502, {'error': 'AI analysis failed.'});
  }
}

Future<void> main() async {
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);
  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 8080);
  stdout.writeln('SOSs AI backend running on port ${server.port}');
}
