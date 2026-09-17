// lib/widgets/container_replacement_card.dart
import 'package:flutter/material.dart';

class ContainerReplacementCard extends StatefulWidget {
  const ContainerReplacementCard({super.key});

  @override
  State<ContainerReplacementCard> createState() => _ContainerReplacementCardState();
}

class _ContainerReplacementCardState extends State<ContainerReplacementCard> {
  double _replacementSecs = 18.4;

  void _simulateDisconnect() {
    setState(() => _replacementSecs = 14.2);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Container successfully auto-replaced in 14.2s!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Database Disconnect Auto-Replacement Engine', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Simulated Container Recovery'),
          subtitle: Text('Current Recovery Latency: ${_replacementSecs.toStringAsFixed(1)}s (< 60s Target)'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _simulateDisconnect,
            icon: const Icon(Icons.published_with_changes),
            label: const Text('SIMULATE DISCONNECT & AUTO-REPLACE'),
          ),
        ),
      ],
    );
  }
}
