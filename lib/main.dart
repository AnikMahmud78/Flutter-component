// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/cloud_run_health_card.dart';
import 'widgets/ietf_health_banner.dart';

void main() {
  runApp(const HealthApp());
}

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Run Health Route',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HealthScreen(),
    );
  }
}

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cloud Run Health (GEN-00458)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            IetfHealthBanner(status: 'Pass', latencyMs: 1.8),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CloudRunHealthCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
