// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sos/main.dart';
import 'package:sos/services/sos_ai_service.dart';

void main() {
  testWidgets('SOSs app loads the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SOSsApp());

    expect(find.text('SOSs'), findsOneWidget);
    expect(find.text('A calmer space, together'), findsOneWidget);
    expect(find.text('How are you feeling today?'), findsOneWidget);
    expect(find.text('Sensory Journal'), findsOneWidget);
  });

  testWidgets('support preferences persist after leaving the page', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const SOSsApp());

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Loud sounds'));
    await tester.pump();

    final selectedBeforeLeaving = tester.widget<CheckboxListTile>(
      find.widgetWithText(CheckboxListTile, 'Loud sounds'),
    );
    expect(selectedBeforeLeaving.value, isTrue);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    final selectedAfterReopening = tester.widget<CheckboxListTile>(
      find.widgetWithText(CheckboxListTile, 'Loud sounds'),
    );
    expect(selectedAfterReopening.value, isTrue);
  });

  testWidgets('AI analysis displays a structured support summary', (
    WidgetTester tester,
  ) async {
    final service = SosAiService(
      baseUrl: 'http://test',
      client: MockClient((request) async {
        expect(request.url.path, '/analyse');
        return http.Response(
          '{"summary":"Noise was reported as difficult.",'
          '"reported_triggers":["Loud sounds"],'
          '"context_summary":"A caregiver report was provided.",'
          '"suggested_adjustments":["lower_media_volume","give_space"],'
          '"caregiver_message":"Reduce sound and offer space.",'
          '"uncertainty":"The exact source is unknown."}',
          200,
        );
      }),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: SosAiAnalysisScreen(selectedNeed: 'Too noisy', service: service),
      ),
    );

    await tester.enterText(
      find.byType(TextField),
      'The caregiver reports that loud kitchen sounds are uncomfortable.',
    );
    await tester.tap(find.text('Analyse support needs'));
    await tester.pumpAndSettle();

    expect(find.text('AI Support Summary'), findsOneWidget);
    expect(find.text('Noise was reported as difficult.'), findsOneWidget);
    await tester.ensureVisible(find.text('Suggested adjustments for review'));
    expect(find.textContaining('lower media volume'), findsOneWidget);
    expect(find.textContaining('No device changes were made'), findsOneWidget);
    service.dispose();
  });
}
