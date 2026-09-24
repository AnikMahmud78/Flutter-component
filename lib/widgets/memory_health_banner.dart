import 'package:flutter/material.dart';

class MemoryHealthBanner extends StatelessWidget {
  final double completionRate;

  const MemoryHealthBanner({super.key, required this.completionRate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool pass = completionRate >= 90.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: pass ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Aggressive Unmount Efficiency: \$completionRate% (Floor: 90.0%)',
        style: theme.textTheme.titleSmall?.copyWith(
          color: pass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
