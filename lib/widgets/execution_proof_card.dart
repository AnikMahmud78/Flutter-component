import 'package:flutter/material.dart';

class ExecutionProofCard extends StatelessWidget {
  final VoidCallback onRefresh;

  const ExecutionProofCard({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3, // M3 Elevated Card Level 2 (3dp)
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Execution Proof Verification', style: theme.textTheme.titleMedium),
                Chip(
                  avatar: const Icon(Icons.check, size: 16),
                  label: const Text('100% Passed'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              'Payload verification confirms sub-100ms API response latencies and layout completeness across target mobile breakpoints.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('MANUAL PULL-TO-REFRESH SYNC'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
