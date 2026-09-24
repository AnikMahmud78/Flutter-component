import 'package:flutter/material.dart';
import 'widgets/metric_proximity_group.dart';
import 'models/grouped_metric.dart';

void main() {
  runApp(const MetricProximityApp());
}

class MetricProximityApp extends StatelessWidget {
  const MetricProximityApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final telemetryMetrics = [
      GroupedMetric(title: 'CPU Usage', value: '42', unit: '%', status: 'Real-time'),
      GroupedMetric(title: 'Memory', value: '1.2', unit: 'GB', status: 'Real-time'),
      GroupedMetric(title: 'API Latency', value: '38', unit: 'ms', status: 'Real-time'),
    ];

    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: const Text('Proximity Metric Grouping')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MetricProximityGroup(groupTitle: 'Core Node Performance', metrics: telemetryMetrics),
            ],
          ),
        ),
      ),
    );
  }
}
