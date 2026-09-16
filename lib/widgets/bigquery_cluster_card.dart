// lib/widgets/bigquery_cluster_card.dart
import 'package:flutter/material.dart';

class BigQueryClusterCard extends StatelessWidget {
  const BigQueryClusterCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BigQuery Schema Clustering Specification', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Partitioning: event_date'),
          subtitle: const Text('Clustering Keys: lineage_trace_id, event_type'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.table_chart),
            label: const Text('VALIDATE CLUSTER LOOKUP SPEED'),
          ),
        ),
      ],
    );
  }
}
