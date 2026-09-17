// lib/widgets/m3_surface_container.dart
import 'package:flutter/material.dart';

class M3SurfaceContainer extends StatelessWidget {
  const M3SurfaceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MD3 Surface & Ripple Container', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12.0),
          child: Ink(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Surface Level 2 Container (3dp)', style: theme.textTheme.bodyMedium),
                Icon(Icons.touch_app, color: theme.colorScheme.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
