// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/query_benchmark_card.dart';
import 'widgets/bq_benchmark_banner.dart';

void main() {
  runApp(const BenchmarkApp());
}

class BenchmarkApp extends StatelessWidget {
  const BenchmarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Query Execution Benchmark',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const BenchmarkScreen(),
    );
  }
}

class BenchmarkScreen extends StatelessWidget {
  const BenchmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Query Benchmark (GEN-00756)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            BqBenchmarkBanner(status: 'Pass', timeSecs: 0.9),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: QueryBenchmarkCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
