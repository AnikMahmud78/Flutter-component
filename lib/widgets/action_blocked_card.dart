import 'package:flutter/material.dart';
import '../models/blocked_state_model.dart';

class ActionBlockedCard extends StatelessWidget {
  final BlockedStateModel model;

  const ActionBlockedCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.block, color: theme.colorScheme.onErrorContainer, size: 28),
                const SizedBox(width: 8.0),
                Text(
                  'ACTION BLOCKED',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              'Reason: ${model.blockReason}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.onErrorContainer,
                  minimumSize: const Size(48, 48),
                ),
                child: const Text('Request Access Elevation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
