import 'package:flutter/material.dart';
import '../models/mathematical_validation_model.dart';

class MathValidationCard extends StatelessWidget {
  final MathematicalValidationModel model;
  final VoidCallback onRefresh;

  const MathValidationCard({
    super.key,
    required this.model,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext meContext) {
    final theme = Theme.of(meContext);
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task: ${model.taskId}',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(model.status.name.toUpperCase()),
                  backgroundColor: model.status == ValidationStatus.complete
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.errorContainer,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('Value A: ${model.valueA} | Value B: ${model.valueB}', style: theme.textTheme.bodyMedium),
            Text('Calculated Delta (A - B): ${model.delta}', style: theme.textTheme.bodyMedium),
            Text('Validation Accuracy: ${model.validationAccuracy.toStringAsFixed(2)}%', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.sync),
                label: const Text('Re-run Automatic Check'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(48, 48),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
