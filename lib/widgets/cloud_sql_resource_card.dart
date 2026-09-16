// lib/widgets/cloud_sql_resource_card.dart
import 'package:flutter/material.dart';

class CloudSqlResourceCard extends StatelessWidget {
  const CloudSqlResourceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PostgreSQL Instance Definition', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Instance: gacl-pg-primary-2026'),
          subtitle: const Text('PostgreSQL 16 | HA Enabled | Daily Backups'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.settings),
            label: const Text('INSPECT RESOURCE CONFIGURATION'),
          ),
        ),
      ],
    );
  }
}
