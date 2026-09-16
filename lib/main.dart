// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/privacy_sandbox_gate.dart';
import 'widgets/privacy_compliance_banner.dart';

void main() {
  runApp(const PrivacySandboxApp());
}

class PrivacySandboxApp extends StatelessWidget {
  const PrivacySandboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Privacy Sandbox Consent Gate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PrivacyScreen(),
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Sandbox (GEN-00447)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PrivacyComplianceBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: PrivacySandboxGate(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
