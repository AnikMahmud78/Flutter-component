import 'package:flutter/material.dart';
import '../models/devops_metrics_model.dart';

class DevOpsMetricsCard extends StatelessWidget {
  final DevOpsMetricsModel model;
  final VoidCallback onRefresh;

  const DevOpsMetricsCard({
    Key? key,
    required this.model,
    required this.onRefresh,
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
            Text('DevOps Build & Compliance Health', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('CI/CD Pass Rate: \${(model.buildPassRate * 100).toStringAsFixed(1)}%'),
                Text('Compliance: \${(model.complianceScore * 100).toStringAsFixed(1)}%'),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.build_circle),
                label: const Text('Refresh Build Telemetry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
