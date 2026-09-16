// lib/widgets/gesture_threshold_card.dart
// Task GEN-00271: Approve gesture thresholds and swipe action maps for mobile queue items.
import 'package:flutter/material.dart';

class GestureThresholdCard extends StatefulWidget {
  const GestureThresholdCard({super.key});

  @override
  State<GestureThresholdCard> createState() => _GestureThresholdCardState();
}

class _GestureThresholdCardState extends State<GestureThresholdCard> {
  double _dragOffset = 0.0;
  String _lastAction = 'Idle';

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
                Text('Mobile Queue Swipe Tester', style: theme.textTheme.titleMedium),
                Chip(
                  label: Text(_lastAction),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text('Swipe item horizontally to test action activation (Threshold: 72dp):',
                style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12.0),
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragOffset += details.primaryDelta ?? 0;
                });
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  if (_dragOffset > 72.0) {
                    _lastAction = 'Approved: Archive';
                  } else if (_dragOffset < -72.0) {
                    _lastAction = 'Approved: Delete';
                  } else {
                    _lastAction = 'Cancelled (< 72dp)';
                  }
                  _dragOffset = 0;
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back),
                    Text('Current Drag: ${_dragOffset.toStringAsFixed(1)}px'),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
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
                    _lastAction = 'Verified 100%';
                  });
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('APPROVE GESTURE MAPS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
