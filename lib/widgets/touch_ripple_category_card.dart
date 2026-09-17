// lib/widgets/touch_ripple_category_card.dart
import 'package:flutter/material.dart';

class TouchRippleCategoryCard extends StatelessWidget {
  const TouchRippleCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Category Tap Touch Ripple Feedback', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Category tapped with instant ink ripple!')),
            );
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Ink(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Electronics & Gadgets', style: theme.textTheme.bodyMedium),
                Icon(Icons.chevron_right, color: theme.colorScheme.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
