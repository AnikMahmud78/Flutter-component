import 'package:flutter/material.dart';

class FailClosedBlockingBanner extends StatelessWidget {
  final String title;
  final String message;

  const FailClosedBlockingBanner({
    super.key,
    this.title = 'SYSTEM HALTED: FAIL-CLOSED SECURITY BLOCK',
    this.message =
        'Perimeter constraints or schema validation checks failed. Database write-access and active navigation steps are physically locked.',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // REQUIREMENT: Full-width un-dismissible top banner in MD3 layout style
    return Container(
      width: double.infinity, // Full-Width
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ), // 16px Spacing Rules
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        border: Border(
          bottom: BorderSide(color: colorScheme.error, width: 2.0),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.error.withAlpha(40),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // High-Contrast Warning Icon
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colorScheme.error,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.block_rounded,
                color: colorScheme.onError,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            // Banner Title & Explanation Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onErrorContainer,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onErrorContainer,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
