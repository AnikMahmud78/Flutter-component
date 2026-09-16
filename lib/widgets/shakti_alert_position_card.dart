// lib/widgets/shakti_alert_position_card.dart
// Task GEN-00337: Position the Shakti Alert panel above all other mobile dashboard content when active.
import 'package:flutter/material.dart';

class ShaktiAlertPositionCard extends StatefulWidget {
  const ShaktiAlertPositionCard({super.key});

  @override
  State<ShaktiAlertPositionCard> createState() => _ShaktiAlertPositionCardState();
}

class _ShaktiAlertPositionCardState extends State<ShaktiAlertPositionCard> {
  bool _alertRaised = true;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shakti Alert Top-Overlay Layer', style: theme.textTheme.titleMedium),
                Chip(
                  label: Text(_alertRaised ? 'ALERT ACTIVE' : 'STANDBY'),
                  backgroundColor: _alertRaised
                      ? theme.colorScheme.errorContainer
                      : theme.colorScheme.surfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            if (_alertRaised)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: theme.colorScheme.error),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: theme.colorScheme.error),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'PRIORITY OVERLAY: Shakti Emergency Alert displayed above all viewports.',
                        style: TextStyle(
                          color: theme.colorScheme.onErrorContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {
                  setState(() {
                    _alertRaised = !_alertRaised;
                  });
                },
                icon: const Icon(Icons.swap_vert),
                label: const Text('TOGGLE ALERT OVERLAY STATE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
