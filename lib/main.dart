import 'package:flutter/material.dart';
import 'models/abandonment_metric.dart';
import 'widgets/single_column_layout.dart';

void main() {
  runApp(const AbandonmentPreventionApp());
}

class AbandonmentPreventionApp extends StatelessWidget {
  const AbandonmentPreventionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Abandonment Prevention',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Single-Column Mobile UX')),
        body: SingleColumnLayoutWidget(
          metric: AbandonmentMetric(
            abandonmentRate: 0.12,
            riskLevel: 'Low',
            timestamp: DateTime.now(),
          ),
        ),
      ),
    );
  }
}
