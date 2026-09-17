// lib/widgets/mto_efficiency_card.dart
import 'package:flutter/material.dart';

class MtoEfficiencyCard extends StatelessWidget {
  const MtoEfficiencyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MTO Workforce Efficiency Metrics', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Active Queue Depth: 14 Tasks'),
          subtitle: const Text('Avg Turnaround Time: 12.4 mins'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.insights),
            label: const Text('DRILL DOWN QUEUE DETAILS'),
          ),
        ),
      ],
    );
  }
}
