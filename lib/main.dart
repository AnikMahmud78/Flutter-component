import 'package:flutter/material.dart';
import 'models/aggregated_benchmark.dart';
import 'widgets/aggregated_chart_block.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global Command Panel',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const CommandPanelScreen(),
    );
  }
}

class CommandPanelScreen extends StatelessWidget {
  const CommandPanelScreen({super.key});

  List<AggregatedBenchmark> get _sampleBenchmarks => [
    AggregatedBenchmark(
      id: 'BM-01',
      metricName: 'Checkout Throughput',
      currentValue: 98.5,
      targetValue: 100.0,
      unit: 'req/s',
      statusColor: Colors.green.shade700,
    ),
    AggregatedBenchmark(
      id: 'BM-02',
      metricName: 'Payload Drop Rate',
      currentValue: 0.2,
      targetValue: 0.5,
      unit: '%',
      statusColor: Colors.blue.shade700,
    ),
    AggregatedBenchmark(
      id: 'BM-03',
      metricName: 'SLA Response Time',
      currentValue: 14.2,
      targetValue: 15.0,
      unit: 'mins',
      statusColor: Colors.orange.shade800,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Command Panel'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Command Center Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Real-time analytical ingestion views powered by Kimball Star-Schema Data Model.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // --- AGGREGATED CHART SLOT BLOCK ---
            AggregatedChartBlock(benchmarks: _sampleBenchmarks),

            const SizedBox(height: 24),

            // DATA MODEL SPECIFICATION CARD
            Card(
              color: Colors.blueGrey.shade900,
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analytics Data Model Design Standard:',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Dimensional Model + Materialized + Indexed (Kimball Group)',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
