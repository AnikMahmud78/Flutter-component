// lib/widgets/steps_11_27_gate_card.dart
import 'package:flutter/material.dart';

class Steps1127GateCard extends StatelessWidget {
  const Steps1127GateCard({super.key});

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
                Text('Prerequisite Gate: Steps 11 & 27', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('PASSED'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('• Step 11 (Backtracking Network Buffer) -> VERIFIED'),
            const Text('• Step 27 (Progressive Profiling Step 1 Form) -> VERIFIED'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                child: const Text('UNLOCK STEP DEPENDENCIES'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
