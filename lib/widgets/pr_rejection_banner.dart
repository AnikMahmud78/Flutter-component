import 'package:flutter/material.dart';

class PrRejectionBanner extends StatelessWidget {
  final double prRejectionRate;
  final double floorThreshold;

  const PrRejectionBanner({
    super.key,
    required this.prRejectionRate,
    this.floorThreshold = 95.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isPassing = prRejectionRate >= floorThreshold;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPassing ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        isPassing
            ? 'CI/CD Gate Active: Automated Rejection Rate \$prRejectionRate% exceeds floor (\$floorThreshold%)'
            : 'CRITICAL: CI/CD Enforcement below threshold (\$prRejectionRate% < \$floorThreshold%)',
        style: theme.textTheme.titleSmall?.copyWith(
          color: isPassing ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
