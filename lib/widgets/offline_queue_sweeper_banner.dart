// lib/widgets/offline_queue_sweeper_banner.dart
// Task GEN-00348: Build the background sync worker OfflineQueueSweeper inside @gacl/offline-storage.
import 'package:flutter/material.dart';

class OfflineQueueSweeperBanner extends StatelessWidget {
  final String status;
  final double successRate;

  const OfflineQueueSweeperBanner({
    super.key,
    required this.status,
    this.successRate = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.sync_lock, color: theme.colorScheme.onPrimaryContainer, size: 28.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OfflineQueueSweeper Sync Worker: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Sync Success Rate: ${(successRate * 100).toInt()}% | ISO/IEC 25010 Fault Tolerance',
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
