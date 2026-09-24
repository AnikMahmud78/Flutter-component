import 'package:flutter/material.dart';
import '../models/catalog_bi_metrics_model.dart';

class CatalogBiDashboardCard extends StatelessWidget {
  final CatalogBiMetricsModel model;
  final VoidCallback onRefresh;

  const CatalogBiDashboardCard({
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Catalog BI ID: \${model.dashboardId}',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Chip(
                  avatar: const Icon(Icons.sync, size: 16.0),
                  label: Text('Status: \${model.completionStatus}'),
                  backgroundColor: model.completionStatus == 'Good'
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bounce Rate', style: theme.textTheme.bodySmall),
                    Text(
                      '\${model.bounceRatePercentage.toStringAsFixed(1)}%',
                      style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Avg Dwell Time', style: theme.textTheme.bodySmall),
                    Text(
                      '\${model.avgTabDwellTimeSeconds.toStringAsFixed(1)}s',
                      style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.secondary),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh Dashboard Telemetry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
