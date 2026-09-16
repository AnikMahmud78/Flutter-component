// lib/widgets/sync_dedup_card.dart
import 'package:flutter/material.dart';

class SyncDedupCard extends StatelessWidget {
  const SyncDedupCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Server Sync Dedup Table DDL Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Table: audit.client_sync_dedup'),
          subtitle: const Text('Partition: DATE(sync_timestamp) | Cluster: client_event_id'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.table_rows),
            label: const Text('VERIFY DEDUP TABLE DDL'),
          ),
        ),
      ],
    );
  }
}
