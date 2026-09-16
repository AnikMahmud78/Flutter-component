// lib/widgets/process_conformance_banner.dart
import 'package:flutter/material.dart';

class ProcessConformanceBanner extends StatelessWidget {
  final String status;
  final double conformanceRate;

  const ProcessConformanceBanner({
    super.key,
    required this.status,
    required this.conformanceRate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isComplete = status == 'Complete' && conformanceRate >= 1.0;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isComplete ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            isComplete ? Icons.restore : Icons.error_outline,
            color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Configuration Conformance: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Agile DoD Alignment: ${(conformanceRate * 100).toStringAsFixed(0)}% Spec Conformance',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isComplete ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
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
