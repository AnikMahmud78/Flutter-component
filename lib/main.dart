// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/payload_size_card.dart';
import 'widgets/mobile_opt_banner.dart';

void main() {
  runApp(const GamificationApp());
}

class GamificationApp extends StatelessWidget {
  const GamificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamification Telemetry Optimization',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const GamificationScreen(),
    );
  }
}

class GamificationScreen extends StatelessWidget {
  const GamificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gamification Telemetry (GEN-00723)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            MobileOptBanner(status: 'Pass', sizeBytes: 342),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: PayloadSizeCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
