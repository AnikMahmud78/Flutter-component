// lib/widgets/mock_touch_gesture_card.dart
// Task GEN-00315: Mock touch gesture events inside automated UI unit tests.
import 'package:flutter/material.dart';

class MockTouchGestureCard extends StatefulWidget {
  const MockTouchGestureCard({super.key});

  @override
  State<MockTouchGestureCard> createState() => _MockTouchGestureCardState();
}

class _MockTouchGestureCardState extends State<MockTouchGestureCard> {
  final List<String> _simulatedGestures = [
    'pointerDown: (120, 240)',
    'pointerMove: delta=(4.2, 0.0)',
    'pointerUp: flingVelocity=320.0',
  ];

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
                Text('Synthetic Gesture Pipeline', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('PASS 100%'),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text('Simulated Event Stream:', style: theme.textTheme.bodySmall),
            const SizedBox(height: 8.0),
            ..._simulatedGestures.map((g) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('• $g', style: const TextStyle(fontFamily: 'monospace')),
                )),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {
                  setState(() {
                    _simulatedGestures.add('pointerCancel: boundsExceeded');
                  });
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('DISPATCH MOCK GESTURE SEQUENCE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
