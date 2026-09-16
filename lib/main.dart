// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/responsive_card_tester.dart';
import 'widgets/viewport_consistency_banner.dart';

void main() {
  runApp(const CardResponsivenessApp());
}

class CardResponsivenessApp extends StatelessWidget {
  const CardResponsivenessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Card Tester',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const CardTestScreen(),
    );
  }
}

class CardTestScreen extends StatelessWidget {
  const CardTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Card (GEN-00170)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ViewportConsistencyBanner(status: 'Pass', hasRegressions: false),
            ResponsiveCardTester(),
          ],
        ),
      ),
    );
  }
}
