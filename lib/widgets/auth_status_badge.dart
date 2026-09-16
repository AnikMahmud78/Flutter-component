// lib/widgets/auth_status_badge.dart
// Task GEN-00159: Secure Authentication Status Badge Component
import 'package:flutter/material.dart';

class AuthStatusBadge extends StatelessWidget {
  final bool isAuthenticated;

  const AuthStatusBadge({super.key, required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: isAuthenticated
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAuthenticated ? Icons.lock : Icons.lock_open,
            size: 16.0,
            color: isAuthenticated
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 6.0),
          Text(
            isAuthenticated ? 'SECURE' : 'UNVERIFIED',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: isAuthenticated
                  ? theme.colorScheme.onPrimaryContainer
                  : theme.colorScheme.onErrorContainer,
            ),
          ),
        ],
      ),
    );
  }
}
