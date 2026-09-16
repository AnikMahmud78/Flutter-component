// lib/widgets/haptic_feedback_card.dart
// Task GEN-00326: Map haptic feedback patterns for all primary mobile interaction events.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HapticFeedbackCard extends StatelessWidget {
  const HapticFeedbackCard({super.key});

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
                Text('Haptic Matrix Controller', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('MAPPED'),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            ListTile(
              dense: true,
              leading: const Icon(Icons.touch_app),
              title: const Text('Light Click -> Selection Change'),
              trailing: IconButton(
                icon: const Icon(Icons.play_circle_outline),
                onPressed: () => HapticFeedback.selectionClick(),
              ),
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Medium Impact -> Form Submission'),
              trailing: IconButton(
                icon: const Icon(Icons.play_circle_outline),
                onPressed: () => HapticFeedback.mediumImpact(),
              ),
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.warning_amber_rounded),
              title: const Text('Heavy Impact -> Error Boundary Trigger'),
              trailing: IconButton(
                icon: const Icon(Icons.play_circle_outline),
                onPressed: () => HapticFeedback.heavyImpact(),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () => HapticFeedback.vibrate(),
                icon: const Icon(Icons.vibration),
                label: const Text('TEST ALL HAPTIC PATTERNS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
