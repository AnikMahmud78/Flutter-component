import 'package:flutter/material.dart';
import '../models/efficiency_metric.dart';

class MtoEfficiencyCard extends StatelessWidget {
  final EfficiencyMetric metric;

  const MtoEfficiencyCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('UI Task Completion Metrics', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text('Baseline Avg Time: \${metric.baselineMinutes} mins'),
            Text('Optimized UI Avg Time: \${metric.optimizedMinutes} mins'),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  metric.passesTarget ? Icons.trending_down : Icons.warning,
                  color: metric.passesTarget ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  'Time Reduction: \${metric.reductionPercentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: metric.passesTarget ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
