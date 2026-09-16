// lib/widgets/steps_6_8_gate_card.dart
import 'package:flutter/material.dart';

class Steps68GateCard extends StatelessWidget {
  const Steps68GateCard({super.key});

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
                Text('Predecessor Gate: Steps 6 & 8', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('VERIFIED'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('• Step 6 (Schema Injection Setup) -> COMPLETE'),
            const Text('• Step 8 (Token Export Initialization) -> COMPLETE'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('PROCEED WITH EXECUTION PHASE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
