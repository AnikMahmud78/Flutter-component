import 'package:flutter/material.dart';
import 'models/efficiency_metric.dart';
import 'widgets/mto_efficiency_card.dart';

void main() => runApp(const EfficiencyApp());

class EfficiencyApp extends StatelessWidget {
  const EfficiencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('MTO Ergonomics Benchmark')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: MtoEfficiencyCard(
            metric: EfficiencyMetric(baselineMinutes: 30.0, optimizedMinutes: 14.5),
          ),
        ),
      ),
    );
  }
}
