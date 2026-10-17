// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sos/main.dart';

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
}
