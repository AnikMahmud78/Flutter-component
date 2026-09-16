// lib/widgets/steps_5_6_gate_card.dart
// Task GEN-00114: Prerequisite Steps 5 and 6 Verification Gate
import 'package:flutter/material.dart';

class Steps56GateCard extends StatelessWidget {
  const Steps56GateCard({super.key});

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
                Text('Prerequisite Verification Node', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('PASSED'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text('Step 5: ED Contract Definition -> PASSED'),
            const Text('Step 6: Schema Injection Setup -> PASSED'),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                child: const Text('UNLOCK DOWNSTREAM STEPS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
