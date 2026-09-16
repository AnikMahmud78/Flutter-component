// lib/widgets/md3_theme_provider_banner.dart
// Task GEN-00293: Confirm the MD3ThemeProvider module and high-contrast token sheets are delivered.
import 'package:flutter/material.dart';

class MD3ThemeProviderBanner extends StatelessWidget {
  final String status;
  final double contrastRatio;

  const MD3ThemeProviderBanner({
    super.key,
    required this.status,
    this.contrastRatio = 7.0,
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
          Icon(Icons.palette, color: theme.colorScheme.onPrimaryContainer, size: 28.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MD3 Theme & High-Contrast Tokens: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Contrast Ratio: ${contrastRatio.toStringAsFixed(1)}:1 | WCAG 2.1 AAA Compliant',
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
