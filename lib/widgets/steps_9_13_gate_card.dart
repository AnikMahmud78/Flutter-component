// lib/widgets/steps_9_13_gate_card.dart
import 'package:flutter/material.dart';

class Steps913GateCard extends StatelessWidget {
  const Steps913GateCard({super.key});

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
                Text('Prerequisite Gate: Steps 9 & 13', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('VERIFIED'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('• Step 9 (Telemetry Ingestion) -> COMPLETE (100%)'),
            const Text('• Step 13 (Dynamic Form Assembly) -> COMPLETE (100%)'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
                label: const Text('PROCEED TO DOWNSTREAM STAGE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
