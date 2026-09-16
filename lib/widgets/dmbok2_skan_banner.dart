// lib/widgets/dmbok2_skan_banner.dart
import 'package:flutter/material.dart';

class Dmbok2SkanBanner extends StatelessWidget {
  final String rating;
  final double fitPct;

  const Dmbok2SkanBanner({
    super.key,
    required this.rating,
    required this.fitPct,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHigh = rating == 'High' && fitPct >= 0.90;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isHigh ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            isHigh ? Icons.insights : Icons.error,
            color: isHigh ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
            size: 24.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SKAN Model Estimation Fit: $rating',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isHigh ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Estimation Fit: ${(fitPct * 100).toStringAsFixed(1)}% (DAMA DMBOK2 Target: ≥ 90%)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isHigh ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
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
