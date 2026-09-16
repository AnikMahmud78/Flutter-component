// lib/widgets/iso22301_continuity_banner.dart
import 'package:flutter/material.dart';

class Iso22301ContinuityBanner extends StatelessWidget {
  final String status;
  final double durationSecs;

  const Iso22301ContinuityBanner({
    super.key,
    required this.status,
    required this.durationSecs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && durationSecs <= 60.0;

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
            isPass ? Icons.alt_route : Icons.cloud_off,
            color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ISO 22301 Failover Duration: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Takeover Time: ${durationSecs.toStringAsFixed(1)}s (Target: ≤ 60 secs)',
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
