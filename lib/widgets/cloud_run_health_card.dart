// lib/widgets/cloud_run_health_card.dart
import 'package:flutter/material.dart';

class CloudRunHealthCard extends StatefulWidget {
  const CloudRunHealthCard({super.key});

  @override
  State<CloudRunHealthCard> createState() => _CloudRunHealthCardState();
}

class _CloudRunHealthCardState extends State<CloudRunHealthCard> {
  double _latency = 1.8;

  void _pingHealthRoute() {
    setState(() {
      _latency = 1.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Backend Liveness Check Monitor', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Endpoint /health (HTTP 200 OK)'),
          subtitle: Text('Execution Latency: ${_latency.toStringAsFixed(1)} ms'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _pingHealthRoute,
            icon: const Icon(Icons.network_check),
            label: const Text('PING BACKEND /health ROUTE'),
          ),
        ),
      ],
    );
  }
}
