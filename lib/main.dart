import 'package:flutter/material.dart';
import 'widgets/progressive_form_wizard.dart';
import 'widgets/friction_telemetry_banner.dart';

void main() {
  runApp(const ProgressiveFormApp());
}

class ProgressiveFormApp extends StatelessWidget {
  const ProgressiveFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progressive Reveal Form',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const ProgressiveFormScreen(),
    );
  }
}

class ProgressiveFormScreen extends StatelessWidget {
  const ProgressiveFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progressive Reveal (FIEVR-044)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const FrictionTelemetryBanner(latencyMs: 450, status: 'Good'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const ProgressiveFormWizard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
