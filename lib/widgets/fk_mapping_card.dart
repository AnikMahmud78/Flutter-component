// lib/widgets/fk_mapping_card.dart
import 'package:flutter/material.dart';
import '../models/attribution_model.dart';

class FkMappingCard extends StatelessWidget {
  final AttributionModel model;

  const FkMappingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ED Model Definition', style: theme.textTheme.titleMedium),
                Chip(
                  label: Text(model.predecessorId != null ? 'FK MAPPED' : 'UNMAPPED'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text('Entity ID: ${model.id}', style: theme.textTheme.bodyMedium),
            Text(
              'predecessor_id: ${model.predecessorId ?? "NULL"}',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('VERIFY DMBOK2 MAPPING'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
