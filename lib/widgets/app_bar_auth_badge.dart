// lib/widgets/app_bar_auth_badge.dart
// Task GEN-00159 (revised): Secure Authentication Status Badge Component
import 'package:flutter/material.dart';

class AppBarAuthBadge extends StatelessWidget {
  final bool isAuthenticated;
  final VoidCallback onTap;

  const AppBarAuthBadge({
    super.key,
    required this.isAuthenticated,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 48.0,
          minHeight: 48.0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: isAuthenticated
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: isAuthenticated
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isAuthenticated ? Icons.lock_outline : Icons.lock_open_outlined,
                    size: 16.0,
                    color: isAuthenticated
                        ? theme.colorScheme.onPrimaryContainer
                        : theme.colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    isAuthenticated ? 'AUTHENTICATED' : 'UNVERIFIED',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: isAuthenticated
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
