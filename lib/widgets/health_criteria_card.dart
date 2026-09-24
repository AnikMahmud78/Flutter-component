import 'package:flutter/material.dart';
import '../models/liveness_health_model.dart';

class HealthCriteriaCard extends StatelessWidget {
  final LivenessHealthModel model;
  final VoidCallback onPing;

  const HealthCriteriaCard({
    super.key,
    required this.model,
    required this.onPing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('HTTP Status: ${model.httpStatusCode}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Measured Latency: ${model.latencyMs} ms'),
            Text('Response State: ${model.healthState.name.toUpperCase()}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onPing,
                icon: const Icon(Icons.speed),
                label: const Text('Execute Liveness Probe'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
