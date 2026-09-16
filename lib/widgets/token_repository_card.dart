import 'package:flutter/material.dart';

class TokenRepositoryCard extends StatelessWidget {
  const TokenRepositoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Design System Token Repository', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text(
              'Configured target paths for M3 design tokens and export package structure.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.build),
                label: const Text('EXPORT TOKEN PACKAGES'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
