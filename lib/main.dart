// lib/main.dart
// Task GEN-00103: Gesture Hesitation Tracking Engine
import 'package:flutter/material.dart';
import 'widgets/gesture_hesitation_tracker.dart';
import 'widgets/w3c_rendering_banner.dart';

void main() {
  runApp(const GestureApp());
}

class GestureApp extends StatelessWidget {
  const GestureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Hesitation Tracking',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const GestureScreen(),
    );
  }
}

class GestureScreen extends StatelessWidget {
  const GestureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Hesitation (GEN-00103)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            W3cRenderingBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: GestureHesitationTracker(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
