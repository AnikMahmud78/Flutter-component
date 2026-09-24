import 'package:flutter/material.dart';
import '../models/dropoff_analytics_model.dart';

class DropoffAnalyticsCard extends StatelessWidget {
  final DropoffAnalyticsModel model;
  final VoidCallback onRefreshData;

  const DropoffAnalyticsCard({
    Key? key,
    required this.model,
    required this.onRefreshData,
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
            Text('Stage Drop-Off Breakdown', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Stage: \${model.stageName}', style: theme.textTheme.bodyMedium),
            Text('Drop-Off: \${(model.dropoffRate * 100).toStringAsFixed(1)}%', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: OutlinedButton.icon(
                onPressed: onRefreshData,
                icon: const Icon(Icons.analytics),
                label: const Text('Refresh Pipeline Telemetry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
