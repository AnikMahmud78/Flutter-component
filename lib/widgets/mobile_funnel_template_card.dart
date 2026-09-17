// lib/widgets/mobile_funnel_template_card.dart
import 'package:flutter/material.dart';

class MobileFunnelTemplateCard extends StatelessWidget {
  const MobileFunnelTemplateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('@habot/templates/mobile-funnel Package', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Reusable Mobile Funnel Layout'),
          subtitle: const Text('Baymard Benchmark: 80% Conversion Rate Achieved'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.inventory_2),
            label: const Text('INSPECT TEMPLATE ARTIFACTS'),
          ),
        ),
      ],
    );
  }
}
