// lib/widgets/bq_benchmark_banner.dart
import 'package:flutter/material.dart';

class BqBenchmarkBanner extends StatelessWidget {
  final String status;
  final double timeSecs;

  const BqBenchmarkBanner({
    super.key,
    required this.status,
    required this.timeSecs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && timeSecs <= 3.0;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPass ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            isPass ? Icons.speed : Icons.error,
            color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BigQuery Execution Benchmark: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Execution Time: ${timeSecs.toStringAsFixed(1)}s (Benchmark Target: ≤ 3 secs)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
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
