import 'package:flutter/material.dart';
import '../models/chart_benchmark_model.dart';

class ChartBenchmarkCard extends StatelessWidget {
  final ChartBenchmarkModel model;
  final VoidCallback onBenchmarkChart;

  const ChartBenchmarkCard({
    Key? key,
    required this.model,
    required this.onBenchmarkChart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chart Render Profiler', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Text('Query-to-Vis Time: \${model.loadTimeMs} ms', style: theme.textTheme.titleLarge),
            Text('Accuracy: \${(model.accuracyScore * 100).toStringAsFixed(1)}%', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onBenchmarkChart,
                icon: const Icon(Icons.bar_chart),
                label: const Text('Run Sub-200ms Chart Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
