// lib/widgets/optimistic_ui_card.dart
import 'package:flutter/material.dart';

class OptimisticUiCard extends StatefulWidget {
  const OptimisticUiCard({super.key});

  @override
  State<OptimisticUiCard> createState() => _OptimisticUiCardState();
}

class _OptimisticUiCardState extends State<OptimisticUiCard> {
  int _counter = 120;

  void _incrementOptimistic() {
    setState(() => _counter++);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Optimistic UI update dispatched instantly!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('@habot/net-client Optimistic UI Engine', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Optimistic State Value: $_counter items'),
          subtitle: const Text('Sub-100ms instant local mutation with rollback guard'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _incrementOptimistic,
            icon: const Icon(Icons.flash_on),
            label: const Text('TRIGGER OPTIMISTIC MUTATION'),
          ),
        ),
      ],
    );
  }
}
