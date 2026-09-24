import 'package:flutter/material.dart';
import '../models/contrast_audit_model.dart';

class ContrastCard extends StatelessWidget {
  final ContrastAuditModel model;
  final VoidCallback onReAudit;

  const ContrastCard({
    super.key,
    required this.model,
    required this.onReAudit,
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
            Text('State: Inverted Color Mode', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Calculated Contrast Ratio: ${model.contrastRatio.toStringAsFixed(2)}:1'),
            Text('WCAG AA Standard (≥4.5:1): ${model.contrastRatio >= 4.5 ? "MET" : "FAILED"}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onReAudit,
                icon: const Icon(Icons.contrast),
                label: const Text('Re-evaluate Contrast Ratio'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
