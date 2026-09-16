import 'package:flutter/material.dart';

class OnboardingCompletenessBanner extends StatelessWidget {
  final String status;
  final double coverage;

  const OnboardingCompletenessBanner({
    super.key,
    required this.status,
    required this.coverage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(Icons.stars, color: theme.colorScheme.onPrimaryContainer, size: 20.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'Step 1 Profiling: $status (${(coverage * 100).toStringAsFixed(0)}% Functional)',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
