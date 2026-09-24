import 'package:flutter/material.dart';

class EscalationHeader extends StatelessWidget {
  final double rate;

  const EscalationHeader({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isPassing = rate >= 90.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPassing ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Calamity Channel Resolution Rate: \$rate% (Floor: 90.0%)',
        style: theme.textTheme.titleMedium?.copyWith(
          color: isPassing ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
