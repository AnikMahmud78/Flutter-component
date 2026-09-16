// lib/widgets/skan_model_card.dart
import 'package:flutter/material.dart';

class SkanModelCard extends StatelessWidget {
  const SkanModelCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SKAN Probabilistic Model Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Model: bq_skan_probabilistic_v2'),
          subtitle: const Text('Estimation Fit: 96.2% (High) | Blended SKAN + First-Party'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.psychology),
            label: const Text('RUN SKAN PROBABILISTIC MODEL'),
          ),
        ),
      ],
    );
  }
}
