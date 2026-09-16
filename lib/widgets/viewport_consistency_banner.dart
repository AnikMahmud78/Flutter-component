// lib/widgets/viewport_consistency_banner.dart
import 'package:flutter/material.dart';

class ViewportConsistencyBanner extends StatelessWidget {
  final String status;
  final bool hasRegressions;

  const ViewportConsistencyBanner({
    super.key,
    required this.status,
    required this.hasRegressions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && !hasRegressions;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPass ? theme.colorScheme.secondaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isPass ? theme.colorScheme.secondary : theme.colorScheme.error,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isPass ? Icons.devices : Icons.mobile_off,
            color: isPass ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cross-Viewport Consistency: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPass ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  '360px Portrait Breakpoint Audit: ${!hasRegressions ? "ZERO REGRESSIONS" : "FAIL"}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isPass ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onErrorContainer,
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
