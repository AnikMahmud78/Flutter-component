import 'package:flutter/material.dart';
import '../models/calamity_gap_model.dart';

class CalamityAlertCard extends StatelessWidget {
  final CalamityGapModel model;
  final VoidCallback onAcknowledge;

  const CalamityAlertCard({
    super.key,
    required this.model,
    required this.onAcknowledge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gap ID: ${model.gapId}', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8.0),
            Text('Issue: ${model.description}', style: theme.textTheme.bodyMedium),
            Text('Status: ${model.status.name.toUpperCase()}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton(
                onPressed: onAcknowledge,
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
                child: const Text('Executive Sign-off & Resolve'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
