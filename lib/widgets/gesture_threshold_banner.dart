// lib/widgets/gesture_threshold_banner.dart
// Task GEN-00271: Approve gesture thresholds and swipe action maps for mobile queue items.
import 'package:flutter/material.dart';

class GestureThresholdBanner extends StatelessWidget {
  final String status;
  final double thresholdPx;

  const GestureThresholdBanner({
    super.key,
    required this.status,
    this.thresholdPx = 72.0,
  });

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
          Icon(Icons.swipe, color: theme.colorScheme.onPrimaryContainer, size: 28.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gesture Threshold Gate: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Swipe Action Threshold: ${thresholdPx}px | Agile DoD Compliant',
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
