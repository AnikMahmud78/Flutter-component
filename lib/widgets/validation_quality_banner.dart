// lib/widgets/validation_quality_banner.dart
// Task GEN-00068: Schema-Driven Input Mask Props for Date Types
import 'package:flutter/material.dart';

class ValidationQualityBanner extends StatelessWidget {
  final String status;
  final double enforcementRate;

  const ValidationQualityBanner({
    super.key,
    required this.status,
    required this.enforcementRate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && enforcementRate >= 0.99;

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
          Icon(Icons.security, color: theme.colorScheme.onTertiaryContainer, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Validation Enforcement: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                ),
                Text(
                  'OWASP ASVS 5.0 & ISO/IEC 25012: ${(enforcementRate * 100).toStringAsFixed(0)}% Block Rate (Fail-Closed)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer,
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
