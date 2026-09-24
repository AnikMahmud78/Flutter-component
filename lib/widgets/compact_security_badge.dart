import 'package:flutter/material.dart';

class CompactSecurityBadge extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const CompactSecurityBadge({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 48.0,
          minHeight: 48.0,
        ),
        alignment: Alignment.center,
        child: Container(
          height: 24.0, // Strict 24dp badge height specification
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: theme.colorScheme.tertiary,
              width: 1.0,
            ),
          ),
          child: Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onTertiaryContainer,
              fontWeight: FontWeight.w600,
              fontSize: 11.0,
            ),
          ),
        ),
      ),
    );
  }
}
