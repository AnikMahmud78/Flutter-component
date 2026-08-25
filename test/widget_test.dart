// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_masked_input/main.dart';

void main() {
  testWidgets('renders print header metadata and UTC timestamp', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PrintHeaderApp());

    expect(find.text('HABOT'), findsOneWidget);
    expect(find.text('Executive Audit Report'), findsOneWidget);
    expect(find.textContaining('Generated: '), findsOneWidget);
    expect(find.textContaining('UTC'), findsOneWidget);
    expect(find.textContaining('TOP_100_HIGH_PRIORITY_RECORDS'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
}
