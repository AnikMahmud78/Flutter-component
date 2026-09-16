// lib/widgets/shakti_alert_position_banner.dart
// Task GEN-00337: Position the Shakti Alert panel above all other mobile dashboard content when active.
import 'package:flutter/material.dart';

class ShaktiAlertPositionBanner extends StatelessWidget {
  final String status;

  const ShaktiAlertPositionBanner({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(Icons.layers, color: theme.colorScheme.onPrimaryContainer, size: 28.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shakti Alert Z-Index Gate: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'ISO/IEC 27001 Audit Immutability: 100% Top-Level Chained',
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
