// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/visual_state_benchmark_card.dart';
import 'widgets/state_persistence_banner.dart';

void main() {
  runApp(const VisualStateBenchmarkScreenApp());
}

class VisualStateBenchmarkScreenApp extends StatelessWidget {
  const VisualStateBenchmarkScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual State Benchmark (GEN-01189)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const VisualStateBenchmarkScreen(),
    );
  }
}

class VisualStateBenchmarkScreen extends StatelessWidget {
  const VisualStateBenchmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visual State Benchmark (GEN-01189)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            StatePersistenceBanner(status: 'Pass', reliability: 1.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: VisualStateBenchmarkCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
