import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final bool isPass;

  const StatusChip({
    Key? key,
    required this.label,
    required this.isPass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = isPass
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.errorContainer;
    final textColor = isPass
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onErrorContainer;

    return Container(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
