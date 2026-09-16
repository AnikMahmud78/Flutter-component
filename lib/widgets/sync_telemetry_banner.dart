import 'package:flutter/material.dart';

class SyncTelemetryBanner extends StatelessWidget {
  final String status;
  final double qualityScore;

  const SyncTelemetryBanner({
    super.key,
    required this.status,
    required this.qualityScore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isGood = qualityScore >= 0.98;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isGood ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: isGood ? theme.colorScheme.primary : theme.colorScheme.error),
      ),
      child: Row(
        children: [
          Icon(
            isGood ? Icons.cloud_done : Icons.cloud_off,
            color: isGood ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Network Sync Execution: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isGood ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'ISO 9001:2015 Execution Quality: ${(qualityScore * 100).toStringAsFixed(0)}% (Optimal Target: 98%+)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isGood ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
