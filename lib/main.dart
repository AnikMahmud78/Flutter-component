// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/api_latency_card.dart';
import 'widgets/iso25010_efficiency_banner.dart';

void main() {
  runApp(const ApiLatencyApp());
}

class ApiLatencyApp extends StatelessWidget {
  const ApiLatencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Latency SLA Monitor',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const LatencyScreen(),
    );
  }
}

class LatencyScreen extends StatelessWidget {
  const LatencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Response Latency (GEN-00833)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Iso25010EfficiencyBanner(status: 'Pass', latencyMs: 38.2),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ApiLatencyCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
