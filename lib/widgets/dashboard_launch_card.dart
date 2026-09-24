import 'package:flutter/material.dart';
import '../models/launch_benchmark_model.dart';

class DashboardLaunchCard extends StatelessWidget {
  final LaunchBenchmarkModel model;
  final VoidCallback onRunBenchmark;

  const DashboardLaunchCard({
    Key? key,
    required this.model,
    required this.onRunBenchmark,
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
            Text('Dashboard Launch Benchmark', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Text('Render Latency: \${model.renderTimeMs} ms', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8.0),
            Chip(
              avatar: const Icon(Icons.speed, color: Colors.blue),
              label: Text('Status: \${model.completionStatus}'),
              backgroundColor: Colors.blue.shade50,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onRunBenchmark,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Benchmark Launch Time'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
