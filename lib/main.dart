// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/health_probe_card.dart';
import 'widgets/health_probe_banner.dart';

void main() {
  runApp(const HealthProbeScreenApp());
}

class HealthProbeScreenApp extends StatelessWidget {
  const HealthProbeScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Probe Architecture (GEN-01012)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HealthProbeScreen(),
    );
  }
}

class HealthProbeScreen extends StatelessWidget {
  const HealthProbeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Probe Architecture (GEN-01012)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            HealthProbeBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: HealthProbeCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
