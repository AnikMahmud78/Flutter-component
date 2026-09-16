// lib/widgets/latency_telemetry_banner.dart
import 'package:flutter/material.dart';

class LatencyTelemetryBanner extends StatelessWidget {
  final String status;
  final int latencyMs;

  const LatencyTelemetryBanner({
    super.key,
    required this.status,
    required this.latencyMs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && latencyMs <= 1000;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPass ? theme.colorScheme.tertiaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.speed,
            color: isPass ? theme.colorScheme.onTertiaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Telemetry Ingestion Latency: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPass ? theme.colorScheme.onTertiaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Streaming Ingestion Latency: ${latencyMs}ms (Optimal Benchmark: ≤ 1000ms)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isPass ? theme.colorScheme.onTertiaryContainer : theme.colorScheme.onErrorContainer,
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
