// lib/widgets/responsive_card_tester.dart
import 'package:flutter/material.dart';

class ResponsiveCardTester extends StatelessWidget {
  const ResponsiveCardTester({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '360px Responsive Test Card',
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Chip(
                  label: Text('${width.toInt()}px'),
                  backgroundColor: theme.colorScheme.surfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              'Enforces single-column fluid card layout behavior under 600dp viewports with strict 4px padding grid alignment.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48.0),
                ),
                onPressed: () {},
                icon: const Icon(Icons.aspect_ratio),
                label: const Text('VERIFY 360px LAYOUT BOUNDS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
