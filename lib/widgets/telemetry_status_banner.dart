import 'package:flutter/material.dart';

class TelemetryStatusBanner extends StatelessWidget {
  final String status;
  final double errorRate;

  const TelemetryStatusBanner({
    super.key,
    required this.status,
    required this.errorRate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && errorRate <= 2.0;
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPass 
            ? theme.colorScheme.primaryContainer 
            : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isPass 
              ? theme.colorScheme.primary 
              : theme.colorScheme.error,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isPass ? Icons.check_circle_outline : Icons.warning_amber_rounded,
            color: isPass 
                ? theme.colorScheme.onPrimaryContainer 
                : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Validation Telemetry: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPass 
                        ? theme.colorScheme.onPrimaryContainer 
                        : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Form Field Error Rate: ${errorRate.toStringAsFixed(2)}% (Target: ≤ 2.0%)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isPass 
                        ? theme.colorScheme.onPrimaryContainer 
                        : theme.colorScheme.onErrorContainer,
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
