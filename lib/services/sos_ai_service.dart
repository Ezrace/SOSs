import 'dart:convert';

import 'package:http/http.dart' as http;

class SosAiAnalysis {
  const SosAiAnalysis({
    required this.summary,
    required this.reportedTriggers,
    required this.contextSummary,
    required this.suggestedAdjustments,
    required this.caregiverMessage,
    required this.uncertainty,
  });

  final String summary;
  final List<String> reportedTriggers;
  final String contextSummary;
  final List<String> suggestedAdjustments;
  final String caregiverMessage;
  final String uncertainty;

  factory SosAiAnalysis.fromJson(Map<String, dynamic> json) {
    List<String> readStringList(String key) {
      final value = json[key];
      if (value is! List || !value.every((item) => item is String)) {
        throw const FormatException('AI response contains an invalid list.');
      }
      return value.cast<String>();
    }

    String readString(String key) {
      final value = json[key];
      if (value is! String) {
        throw const FormatException('AI response contains an invalid field.');
      }
      return value;
    }

    return SosAiAnalysis(
      summary: readString('summary'),
      reportedTriggers: readStringList('reported_triggers'),
      contextSummary: readString('context_summary'),
      suggestedAdjustments: readStringList('suggested_adjustments'),
      caregiverMessage: readString('caregiver_message'),
      uncertainty: readString('uncertainty'),
    );
  }
}

class SosAiService {
  SosAiService({required this.baseUrl, http.Client? client})
    : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  Future<SosAiAnalysis> analyse({
    required String note,
    required String selectedNeed,
    required Map<String, dynamic> preferences,
  }) async {
    final trimmedNote = note.trim();
    final trimmedNeed = selectedNeed.trim();
    if (trimmedNote.isEmpty || trimmedNote.length > 2000) {
      throw const SosAiException(
        'Enter a note between 1 and 2,000 characters.',
      );
    }
    if (trimmedNeed.isEmpty || trimmedNeed.length > 100) {
      throw const SosAiException('A selected sensory need is required.');
    }

    final response = await _client
        .post(
          Uri.parse('$baseUrl/analyse'),
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({
            'note': trimmedNote,
            'selectedNeed': trimmedNeed,
            'preferences': preferences,
          }),
        )
        .timeout(const Duration(seconds: 25));

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } on FormatException {
      throw const SosAiException('The AI backend returned invalid JSON.');
    }

    if (response.statusCode != 200) {
      final message = decoded is Map<String, dynamic>
          ? decoded['error']?.toString()
          : null;
      throw SosAiException(message ?? 'AI analysis failed.');
    }
    if (decoded is! Map<String, dynamic>) {
      throw const SosAiException(
        'The AI backend returned an unexpected format.',
      );
    }

    try {
      return SosAiAnalysis.fromJson(decoded);
    } on FormatException {
      throw const SosAiException(
        'The AI returned an incomplete support summary.',
      );
    }
  }

  void dispose() => _client.close();
}

class SosAiException implements Exception {
  const SosAiException(this.message);

  final String message;

  @override
  String toString() => message;
}
