import 'package:flutter/material.dart';
import '../models/gap_container_model.dart';

class GapContainerCard extends StatelessWidget {
  final GapContainerModel model;
  final VoidCallback onVerifyGaps;

  const GapContainerCard({
    Key? key,
    required this.model,
    required this.onVerifyGaps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Auto-Injected Container Gap', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Spacing Gap: \${model.gapDp.toInt()} dp'),
            const SizedBox(height: 12.0),
            // Auto-Gapped Child Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.0,
                    color: theme.colorScheme.primaryContainer,
                    child: const Center(child: Text('Child 1')),
                  ),
                ),
                SizedBox(width: model.gapDp), // Automated 8dp gap injection
                Expanded(
                  child: Container(
                    height: 48.0,
                    color: theme.colorScheme.secondaryContainer,
                    child: const Center(child: Text('Child 2')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onVerifyGaps,
                child: const Text('Verify WCAG 2.1 Spacing'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
