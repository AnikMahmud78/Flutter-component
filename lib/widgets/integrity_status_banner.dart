// lib/widgets/integrity_status_banner.dart
import 'package:flutter/material.dart';

class IntegrityStatusBanner extends StatelessWidget {
  final String status;

  const IntegrityStatusBanner({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isComplete = status == 'Complete';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isComplete ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isComplete ? theme.colorScheme.primary : theme.colorScheme.error,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isComplete ? Icons.account_tree : Icons.link_off,
            color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Relational Integrity Status: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Standard: DAMA DMBOK2 Relational Integrity (100% Target)',
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
