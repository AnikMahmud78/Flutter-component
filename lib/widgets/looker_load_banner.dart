// lib/widgets/looker_load_banner.dart
import 'package:flutter/material.dart';

class LookerLoadBanner extends StatelessWidget {
  final String status;
  final double loadTimeSecs;

  const LookerLoadBanner({
    super.key,
    required this.status,
    required this.loadTimeSecs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isComplete = status == 'Complete' && loadTimeSecs <= 2.0;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isComplete ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            isComplete ? Icons.dashboard : Icons.error,
            color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MTO Efficiency View Status: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Dashboard Load Time: ${loadTimeSecs.toStringAsFixed(1)}s (Target: ≤ 2 secs)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
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
