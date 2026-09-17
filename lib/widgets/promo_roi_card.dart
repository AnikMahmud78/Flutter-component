// lib/widgets/promo_roi_card.dart
import 'package:flutter/material.dart';

class PromoRoiCard extends StatelessWidget {
  const PromoRoiCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Promotional ROI Dashboard', style: theme.textTheme.titleMedium),
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
                      Text('2,841', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      Text('Redemptions', style: theme.textTheme.bodySmall),
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
                      Text('342%', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      Text('ROI', style: theme.textTheme.bodySmall),
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
            icon: const Icon(Icons.bar_chart),
            label: const Text('VIEW FULL PROMO ANALYTICS'),
          ),
        ),
      ],
    );
  }
}
