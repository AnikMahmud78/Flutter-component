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
  testWidgets('mounts four inset-aware navigation destinations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BottomInsetApp());

    expect(find.byType(NavigationDestination), findsNWidgets(4));
    expect(find.text('Detected Gesture Bar Inset: 0.0 dp'), findsOneWidget);

    await tester.tap(find.text('Tasks'));
    await tester.pump();

    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
