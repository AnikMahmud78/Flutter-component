// lib/widgets/fre_completion_banner.dart
import 'package:flutter/material.dart';

class FreCompletionBanner extends StatelessWidget {
  final String status;
  final double completionRate;

  const FreCompletionBanner({
    super.key,
    required this.status,
    required this.completionRate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isGood = status == 'Good';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isGood ? theme.colorScheme.primaryContainer : theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            isGood ? Icons.view_carousel : Icons.info,
            color: isGood ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSecondaryContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'First-Run Experience: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isGood ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSecondaryContainer,
                  ),
                ),
                Text(
                  'FRE Completion Rate: ${(completionRate * 100).toInt()}% (Mobile Growth Benchmark)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isGood ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSecondaryContainer,
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
