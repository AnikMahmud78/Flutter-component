// lib/widgets/ga4_retry_card.dart
import 'package:flutter/material.dart';

class Ga4RetryCard extends StatefulWidget {
  const Ga4RetryCard({super.key});

  @override
  State<Ga4RetryCard> createState() => _Ga4RetryCardState();
}

class _Ga4RetryCardState extends State<Ga4RetryCard> {
  int _attempts = 0;
  bool _routedToDlq = false;

  void _simulateFailedDispatch() {
    setState(() {
      if (_attempts < 5) {
        _attempts++;
      }
      if (_attempts >= 5) {
        _routedToDlq = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('GA4 Measurement Protocol Queue Manager', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Current Dispatch Attempt: $_attempts / 5'),
          subtitle: Text(_routedToDlq ? 'Payload routed to DLQ' : 'Active retry window'),
          trailing: Chip(
            label: Text(_routedToDlq ? 'ROUTED TO DLQ' : 'RETRYING'),
            backgroundColor: _routedToDlq ? theme.colorScheme.errorContainer : theme.colorScheme.surfaceVariant,
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _routedToDlq ? null : _simulateFailedDispatch,
            icon: const Icon(Icons.refresh),
            label: const Text('TRIGGER FAILED GA4 DISPATCH'),
          ),
        ),
      ],
    );
  }
}
