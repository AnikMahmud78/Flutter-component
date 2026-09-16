// lib/widgets/dlq_retry_card.dart
import 'package:flutter/material.dart';

class DlqRetryCard extends StatefulWidget {
  const DlqRetryCard({super.key});

  @override
  State<DlqRetryCard> createState() => _DlqRetryCardState();
}

class _DlqRetryCardState extends State<DlqRetryCard> {
  int _attemptCounter = 0;
  bool _quarantined = false;

  void _incrementRetryAttempt() {
    setState(() {
      if (_attemptCounter < 5) {
        _attemptCounter++;
      }
      if (_attemptCounter >= 5) {
        _quarantined = true;
      }
    });
  }

  void _resetQueue() {
    setState(() {
      _attemptCounter = 0;
      _quarantined = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DLQ Ingress Message Retry Monitor', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active Retry Count: $_attemptCounter / 5'),
                Chip(
                  label: Text(_quarantined ? 'DLQ QUARANTINED' : 'RETRYING'),
                  backgroundColor: _quarantined ? theme.colorScheme.errorContainer : theme.colorScheme.surfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: OutlinedButton(
                      onPressed: _quarantined ? null : _incrementRetryAttempt,
                      child: const Text('TRIGGER RETRY'),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: ElevatedButton(
                      onPressed: _resetQueue,
                      child: const Text('PURGE QUEUE'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
