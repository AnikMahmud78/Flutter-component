// lib/widgets/wcag_accessibility_banner.dart
// Task GEN-00092: Confirm Enforced 48dp Touch Bounds Delivery
import 'package:flutter/material.dart';

class WcagAccessibilityBanner extends StatelessWidget {
  final String status;
  final int touchDp;

  const WcagAccessibilityBanner({
    super.key,
    required this.status,
    required this.touchDp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPass = status == 'Pass' && touchDp >= 48;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isPass ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.touch_app, color: theme.colorScheme.onPrimaryContainer, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WCAG 2.1 SC 2.5.5 Status: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  'Enforced Touch Target: ${touchDp}x${touchDp}dp (Material Design 3 Standard)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
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
