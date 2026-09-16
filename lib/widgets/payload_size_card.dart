// lib/widgets/payload_size_card.dart
import 'package:flutter/material.dart';

class PayloadSizeCard extends StatelessWidget {
  const PayloadSizeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gamification Event Payload Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Event: GAMIFY_LOYALTY_STREAK_BONUS'),
          subtitle: const Text('Serialized Payload Size: 342 Bytes (0.33 KB)'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.data_usage),
            label: const Text('DISPATCH GAMIFICATION EVENT'),
          ),
        ),
      ],
    );
  }
}
