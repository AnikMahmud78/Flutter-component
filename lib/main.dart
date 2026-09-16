// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/dashboard_counter_updater.dart';
import 'widgets/sre_latency_banner.dart';

void main() {
  runApp(const CounterUpdateApp());
}

class CounterUpdateApp extends StatelessWidget {
  const CounterUpdateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Counter Refresh',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Counters (GEN-00249)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SreLatencyBanner(status: 'Pass', latencyMs: 180),
            DashboardCounterUpdater(),
          ],
        ),
      ),
    );
  }
}
