// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/ga4_retry_card.dart';
import 'widgets/sre_queue_banner.dart';

void main() {
  runApp(const Ga4RetryApp());
}

class Ga4RetryApp extends StatelessWidget {
  const Ga4RetryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GA4 Measurement Protocol Retry',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Ga4Screen(),
    );
  }
}

class Ga4Screen extends StatelessWidget {
  const Ga4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GA4 Telemetry Retry (GEN-00546)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SreQueueBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Ga4RetryCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
