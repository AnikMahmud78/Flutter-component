import 'package:flutter/material.dart';

class FrictionTelemetryBanner extends StatelessWidget {
  final int latencyMs;
  final String status;

  const FrictionTelemetryBanner({
    super.key,
    required this.latencyMs,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOptimal = latencyMs <= 1000;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isOptimal ? theme.colorScheme.surfaceVariant : theme.colorScheme.warningContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.speed, color: theme.colorScheme.primary, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Form Completion Friction: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Step Transition Latency: ${latencyMs}ms (Optimal Benchmark: 1000ms)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
