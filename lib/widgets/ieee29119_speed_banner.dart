// lib/widgets/ieee29119_speed_banner.dart
import 'package:flutter/material.dart';

class Ieee29119SpeedBanner extends StatelessWidget {
  final String status;
  final int detectionMins;

  const Ieee29119SpeedBanner({
    super.key,
    required this.status,
    required this.detectionMins,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && detectionMins <= 60;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPass ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            isPass ? Icons.published_with_changes : Icons.warning,
            color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ISO/IEC/IEEE 29119 Anomaly Gate: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Detection Window: ${detectionMins}m (Target: ≤ 60 mins / 1 hour)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
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
