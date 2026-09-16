// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/telemetry_error_collector.dart';
import 'widgets/latency_telemetry_banner.dart';

void main() {
  runApp(const TelemetryApp());
}

class TelemetryApp extends StatelessWidget {
  const TelemetryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telemetry Capture Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TelemetryScreen(),
    );
  }
}

class TelemetryScreen extends StatelessWidget {
  const TelemetryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Telemetry Capture (GEN-00181)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            LatencyTelemetryBanner(status: 'Pass', latencyMs: 450),
            TelemetryErrorCollector(),
          ],
        ),
      ),
    );
  }
}
