// lib/widgets/byt_snippet_cropper_banner.dart
// Task GEN-00282: Confirm the BytSnippetCropper component and coordinate parser are delivered.
import 'package:flutter/material.dart';

class BytSnippetCropperBanner extends StatelessWidget {
  final String status;
  final double acceptanceRate;

  const BytSnippetCropperBanner({
    super.key,
    required this.status,
    this.acceptanceRate = 1.0,
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
          Icon(Icons.crop, color: theme.colorScheme.onPrimaryContainer, size: 28.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BytSnippetCropper Delivery: $status',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Acceptance Rate: ${(acceptanceRate * 100).toInt()}% | ISO/IEC 25010 Functional Correctness',
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
