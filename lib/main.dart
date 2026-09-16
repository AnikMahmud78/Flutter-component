import 'package:flutter/material.dart';
import 'widgets/silent_hesitation_tracker.dart';
import 'widgets/hesitation_quality_banner.dart';

void main() {
  runApp(const HesitationApp());
}

class HesitationApp extends StatelessWidget {
  const HesitationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silent Hesitation Instrumentation',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const HesitationScreen(),
    );
  }
}

class HesitationScreen extends StatelessWidget {
  const HesitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hesitation Logger (FLADE-015-11)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            HesitationQualityBanner(status: 'Good (100%)', qualityScore: 1.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SilentHesitationTracker(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
