// lib/widgets/service_ctr_card.dart
import 'package:flutter/material.dart';

class ServiceCtrCard extends StatelessWidget {
  const ServiceCtrCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Merchandising CTR Dashboard', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: Card(
                color: theme.colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text('12.4%', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      Text('CTR', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Card(
                color: theme.colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text('1,240', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      Text('Impressions', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.refresh),
            label: const Text('REFRESH MERCHANDISING DATA'),
          ),
        ),
      ],
    );
  }
}
