// lib/widgets/hero_layout_card.dart
import 'package:flutter/material.dart';

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12.0),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.image, size: 64, color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: 12.0),
        Text('Premium Home Cleaning Service', style: theme.textTheme.titleLarge),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('AED 149 / session', style: theme.textTheme.bodyMedium),
            Row(
              children: [
                Icon(Icons.star, color: theme.colorScheme.primary, size: 18),
                Text(' 4.9 (312 reviews)', style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
