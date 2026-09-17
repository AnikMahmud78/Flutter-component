// lib/widgets/shimmer_animation_card.dart
import 'package:flutter/material.dart';

class ShimmerAnimationCard extends StatefulWidget {
  const ShimmerAnimationCard({super.key});

  @override
  State<ShimmerAnimationCard> createState() => _ShimmerAnimationCardState();
}

class _ShimmerAnimationCardState extends State<ShimmerAnimationCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hardware-Accelerated 60fps Shimmer', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.3 + 0.7 * _controller.value),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Text('60fps Shimmer Loading Bar', style: theme.textTheme.bodyMedium),
            );
          },
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.refresh),
            label: const Text('VERIFY 60FPS GPU REFRESH RATE'),
          ),
        ),
      ],
    );
  }
}
