// lib/main.dart
// Main test entry for GEN-00315
import 'package:flutter/material.dart';
import 'widgets/mock_touch_gesture_banner.dart';
import 'widgets/mock_touch_gesture_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GEN-00315 Runner',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                const MockTouchGestureBanner(status: 'Complete'),
            const MockTouchGestureCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
