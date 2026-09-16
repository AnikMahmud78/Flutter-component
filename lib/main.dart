// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/att_consent_card.dart';
import 'widgets/apple_att_banner.dart';

void main() {
  runApp(const AttApp());
}

class AttApp extends StatelessWidget {
  const AttApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATT Consent Handler',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const AttScreen(),
    );
  }
}

class AttScreen extends StatelessWidget {
  const AttScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('iOS ATT Handler (GEN-00502)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppleAttBanner(status: 'Complete', renderTimeMs: 16.4),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: AttConsentCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
