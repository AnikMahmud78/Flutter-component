import 'package:flutter/material.dart';
import 'widgets/latency_benchmark_card.dart';

void main() {
  runApp(const LatencyApp());
}

class LatencyApp extends StatelessWidget {
  const LatencyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: Scaffold(
        appBar: AppBar(title: const Text('Sub-100ms Latency Console')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LatencyBenchmarkCard(
            onLatencyMeasured: (metric) {
              debugPrint('RAIL Latency Log: ${metric.actionName} -> ${metric.latencyMs}ms (${metric.rating})');
            },
          ),
        ),
      ),
    );
  }
}
