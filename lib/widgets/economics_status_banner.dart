import 'package:flutter/material.dart';

class EconomicsStatusBanner extends StatelessWidget {
  final double growthRate;

  const EconomicsStatusBanner({super.key, required this.growthRate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool pass = growthRate >= 15.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: pass ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'CLV Growth Rate: \$growthRate% (Floor Threshold: 15.0%)',
        style: theme.textTheme.titleSmall?.copyWith(
          color: pass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
