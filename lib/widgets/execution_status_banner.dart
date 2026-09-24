import 'package:flutter/material.dart';

class ExecutionStatusBanner extends StatelessWidget {
  final String statusText;
  final bool isPass;

  const ExecutionStatusBanner({
    super.key,
    required this.statusText,
    required this.isPass,
  });

  @override
  Widget build(BuildContext meContext) {
    final theme = Theme.of(meContext);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: isPass ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            isPass ? Icons.check_circle : Icons.error,
            color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              statusText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isPass ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
