// lib/widgets/push_audit_table_card.dart
import 'package:flutter/material.dart';

class PushAuditTableCard extends StatelessWidget {
  const PushAuditTableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BigQuery Audit DDL Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Table: audit.push_notifications_sent'),
          subtitle: const Text('Partition: DATE(sent_timestamp) | Cluster: user_id, push_type'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.difference),
            label: const Text('VERIFY BIGQUERY TABLE DDL'),
          ),
        ),
      ],
    );
  }
}
