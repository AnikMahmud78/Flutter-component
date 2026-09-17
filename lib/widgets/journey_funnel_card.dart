// lib/widgets/journey_funnel_card.dart
import 'package:flutter/material.dart';

class JourneyFunnelCard extends StatelessWidget {
  const JourneyFunnelCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customer Journey Sequence Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Multi-Step Sequence Definitions'),
          subtitle: const Text('1. Ad Click  -> 2. Install -> 3. Onboarding -> 4. Cart -> 5. Purchase'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.analytics),
            label: const Text('VALIDATE GA4 FUNNEL STEPS'),
          ),
        ),
      ],
    );
  }
}
