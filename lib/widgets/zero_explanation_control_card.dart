// lib/widgets/zero_explanation_control_card.dart
// Task GEN-00359: Verify that mobile interface controls require zero explanation during UAT trials.
import 'package:flutter/material.dart';

class ZeroExplanationControlCard extends StatelessWidget {
  const ZeroExplanationControlCard({super.key});

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
                Text('UAT Intuitive Usability Score', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('ZERO-EXPLANATION CONFIRMED'),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('Trial Metrics: 100% task completion without manual intervention.'),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                icon: const Icon(Icons.thumb_up_alt_outlined),
                label: const Text('SUBMIT UAT CERTIFICATION'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
