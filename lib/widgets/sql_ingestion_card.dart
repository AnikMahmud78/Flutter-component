// lib/widgets/sql_ingestion_card.dart
import 'package:flutter/material.dart';

class SqlIngestionCard extends StatelessWidget {
  const SqlIngestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SQL Ingestion Model Specification', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Model: stg_identity_raw_ingestion'),
          subtitle: const Text('Sources: raw_device_tokens, email_hashes_sha256, loyalty_id_map'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.play_arrow),
            label: const Text('EXECUTE SQL INGESTION MODEL'),
          ),
        ),
      ],
    );
  }
}
