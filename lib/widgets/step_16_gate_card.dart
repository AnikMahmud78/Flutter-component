// lib/widgets/step_16_gate_card.dart
// Task GEN-00148: Prerequisite Step 16 Verification Gate
import 'package:flutter/material.dart';

class Step16GateCard extends StatelessWidget {
  const Step16GateCard({super.key});

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
                Text('Step 16 Prerequisite Node', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('PASSED'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text('Step 16: Telemetry Integration -> PASSED'),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                child: const Text('PROCEED TO NEXT STEP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
