import 'package:flutter/material.dart';
import '../models/vector_migration_model.dart';

class AssetComparisonCard extends StatelessWidget {
  final VectorMigrationModel model;
  final VoidCallback onAudit;

  const AssetComparisonCard({
    super.key,
    required this.model,
    required this.onAudit,
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
            Text('Replaced Bitmaps: ${model.totalBitmapsReplaced} assets', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8.0),
            Text('Total Saved Payload: ${model.payloadSavedKb} KB'),
            const SizedBox(height: 12.0),
            Row(
              children: const [
                Icon(Icons.vector_polyline, size: 36, color: Colors.blue),
                SizedBox(width: 12),
                Text('Material Vector Symbol Active'),
              ],
            ),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onAudit,
                icon: const Icon(Icons.analytics),
                label: const Text('Re-calculate Bundle Payload'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
