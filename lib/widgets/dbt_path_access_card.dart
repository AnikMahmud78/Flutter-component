// lib/widgets/dbt_path_access_card.dart
import 'package:flutter/material.dart';

class DbtPathAccessCard extends StatelessWidget {
  const DbtPathAccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('dbt Warehouse Repository Path Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('dbt_warehouse/models/'),
          subtitle: const Text('Models: stg_bank_statements, stg_app_revenue, fn_reconcile'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.folder),
            label: const Text('VERIFY dbt REPOSITORY PATH'),
          ),
        ),
      ],
    );
  }
}
