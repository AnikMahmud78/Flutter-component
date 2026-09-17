// lib/widgets/fre_carousel_card.dart
import 'package:flutter/material.dart';

class FreCarouselCard extends StatelessWidget {
  const FreCarouselCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('@habot/ui/fre-carousel Module', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 80,
          child: PageView(
            children: [
              Card(color: theme.colorScheme.surfaceVariant, child: const Center(child: Text('Slide 1: Welcome to Habot'))),
              Card(color: theme.colorScheme.surfaceVariant, child: const Center(child: Text('Slide 2: Instant Search'))),
              Card(color: theme.colorScheme.surfaceVariant, child: const Center(child: Text('Slide 3: Fast Checkouts'))),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.touch_app),
            label: const Text('VERIFY CAROUSEL ONBOARDING'),
          ),
        ),
      ],
    );
  }
}
