// lib/widgets/reliability_status_banner.dart
// Task GEN-00079: Build LockableFormContainer Component
import 'package:flutter/material.dart';

class ReliabilityStatusBanner extends StatelessWidget {
  final String status;
  final int rtoSeconds;

  const ReliabilityStatusBanner({
    super.key,
    required this.status,
    required this.rtoSeconds,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && rtoSeconds <= 30;

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
          Icon(Icons.lock_reset, color: theme.colorScheme.onPrimaryContainer, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reliability Status: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  'GCP Reliability Pillar RTO: ${rtoSeconds}s (Target: ≤ 30s)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
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
