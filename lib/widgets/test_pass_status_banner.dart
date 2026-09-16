import 'package:flutter/material.dart';

class TestPassStatusBanner extends StatelessWidget {
  final String status;
  final String coverage;

  const TestPassStatusBanner({
    super.key,
    required this.status,
    required this.coverage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPass ? theme.colorScheme.secondaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.checklist, color: theme.colorScheme.onSecondaryContainer, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CI Functional Test Pass: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
                Text(
                  'Test Suite Coverage: $coverage (Automated Regression Active)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
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
