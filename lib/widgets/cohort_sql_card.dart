// lib/widgets/cohort_sql_card.dart
import 'package:flutter/material.dart';

class CohortSqlCard extends StatelessWidget {
  const CohortSqlCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BigQuery SQL Model File Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('cohort_retention_matrix.sql'),
          subtitle: const Text('Dialect: Google BigQuery Standard SQL | Partition: DATE'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.code),
            label: const Text('VERIFY SQL SYNTAX'),
          ),
        ),
      ],
    );
  }
}
