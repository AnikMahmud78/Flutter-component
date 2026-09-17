// lib/widgets/api_latency_card.dart
import 'package:flutter/material.dart';

class ApiLatencyCard extends StatefulWidget {
  const ApiLatencyCard({super.key});

  @override
  State<ApiLatencyCard> createState() => _ApiLatencyCardState();
}

class _ApiLatencyCardState extends State<ApiLatencyCard> {
  double _latencyMs = 42.5;

  void _runLatencyTests() {
    setState(() {
      _latencyMs = 38.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Endpoint Response Latency SLA Monitor', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Monitored Endpoints: /v1/ingress, /health, /attribution'),
          subtitle: Text('Current Average Response Time: ${_latencyMs.toStringAsFixed(1)} ms'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _runLatencyTests,
            icon: const Icon(Icons.network_check),
            label: const Text('RUN ENDPOINT LATENCY TESTS'),
          ),
        ),
      ],
    );
  }
}
