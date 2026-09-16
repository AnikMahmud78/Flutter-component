// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/dlq_retry_card.dart';
import 'widgets/sre_retry_banner.dart';

void main() {
  runApp(const DlqApp());
}

class DlqApp extends StatelessWidget {
  const DlqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DLQ Retry Boundary',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const DlqScreen(),
    );
  }
}

class DlqScreen extends StatelessWidget {
  const DlqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DLQ Retry Config (GEN-00403)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SreRetryBanner(status: 'Pass', maxAttempts: 5),
            DlqRetryCard(),
          ],
        ),
      ),
    );
  }
}
