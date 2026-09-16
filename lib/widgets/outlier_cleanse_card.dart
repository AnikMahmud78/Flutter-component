// lib/widgets/outlier_cleanse_card.dart
import 'package:flutter/material.dart';

class OutlierCleanseCard extends StatelessWidget {
  const OutlierCleanseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BigQuery ML Data Cleanse Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Filter Rule: amount BETWEEN 0.01 AND 10000.00'),
          subtitle: const Text('Status: 142 Outlier Test Rows Removed Prior to Training'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.filter_alt),
            label: const Text('APPLY OUTLIER CLEANSE RULES'),
          ),
        ),
      ],
    );
  }
}
