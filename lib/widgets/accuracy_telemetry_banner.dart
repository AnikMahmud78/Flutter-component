import 'package:flutter/material.dart';

class AccuracyTelemetryBanner extends StatelessWidget {
  final double accuracyRate;
  final String status;

  const AccuracyTelemetryBanner({
    super.key,
    required this.accuracyRate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isGood = accuracyRate >= 0.97 && status == 'Good';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isGood ? theme.colorScheme.tertiaryContainer : theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: theme.colorScheme.tertiary, width: 1.0),
      ),
      child: Row(
        children: [
          Icon(Icons.precision_manufacturing, color: theme.colorScheme.onTertiaryContainer, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ISO 9001:2015 Execution Status: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                ),
                Text(
                  'Accuracy Score: ${(accuracyRate * 100).toStringAsFixed(1)}% (Floor: 90%, Target: 97%+)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer,
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
