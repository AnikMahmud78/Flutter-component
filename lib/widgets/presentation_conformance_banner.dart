// lib/widgets/presentation_conformance_banner.dart
// Task GEN-00159 (revised): Secure Authentication Status Badge Component
import 'package:flutter/material.dart';

class PresentationConformanceBanner extends StatelessWidget {
  final String status;
  final double conformanceScore;

  const PresentationConformanceBanner({
    super.key,
    required this.status,
    required this.conformanceScore,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && conformanceScore >= 1.0;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPass ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isPass ? theme.colorScheme.primary : theme.colorScheme.error,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isPass ? Icons.verified_user : Icons.gpp_bad,
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
                  'UI Presentation Conformance: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPass
                        ? theme.colorScheme.onPrimaryContainer
                        : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Material Design 3 Conformance: ${(conformanceScore * 100).toStringAsFixed(0)}% (Target: 100%)',
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
