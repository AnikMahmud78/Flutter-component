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
  testWidgets('toggles print mode and strips non-essential controls', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PrintPreviewApp());

    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.byType(FloatingActionButton), findsNothing);
    expect(find.byType(AppBar), findsNothing);
    expect(find.text('Print Preview Canvas'), findsOneWidget);
  });
}
