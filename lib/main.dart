// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/ai_query_verifier_card.dart';
import 'widgets/ieee29119_audit_banner.dart';

void main() {
  runApp(const AiQueryApp());
}

class AiQueryApp extends StatelessWidget {
  const AiQueryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Marketing Query Verifier',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AiQueryScreen(),
    );
  }
}

class AiQueryScreen extends StatelessWidget {
  const AiQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Marketing Query (GEN-00590)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Ieee29119AuditBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: AiQueryVerifierCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
