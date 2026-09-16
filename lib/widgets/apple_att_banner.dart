// lib/widgets/apple_att_banner.dart
import 'package:flutter/material.dart';

class AppleAttBanner extends StatelessWidget {
  final String status;
  final double renderTimeMs;

  const AppleAttBanner({
    super.key,
    required this.status,
    required this.renderTimeMs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isComplete = status == 'Complete' && renderTimeMs <= 100.0;

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
            isComplete ? Icons.security_update_good : Icons.error,
            color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apple ATT Dialog Status: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Render Time: ${renderTimeMs.toStringAsFixed(1)} ms (Apple HIG Spec Target: ≤ 100 ms)',
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
