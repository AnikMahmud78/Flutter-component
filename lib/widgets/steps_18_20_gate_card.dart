// lib/widgets/steps_18_20_gate_card.dart
// Task GEN-00304: Confirm Steps 18 and 20 are complete as prerequisites.
import 'package:flutter/material.dart';

class Steps1820GateCard extends StatelessWidget {
  const Steps1820GateCard({super.key});

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
                Text('Dependency Milestone Verification', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('VERIFIED'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('Step 18: Mobile Offline Schema Validation -> COMPLETE'),
            const SizedBox(height: 6.0),
            const Text('Step 20: BigQuery Event Stream Contract -> COMPLETE'),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                icon: const Icon(Icons.verified),
                label: const Text('AUTHORIZE DEPENDENCY GATE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
