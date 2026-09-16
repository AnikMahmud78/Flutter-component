import 'package:flutter/material.dart';

class DependencyGateCard extends StatelessWidget {
  const DependencyGateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Predecessor Step 1 (ED)', style: theme.textTheme.titleMedium),
                Chip(
                  avatar: const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  label: const Text('VERIFIED'),
                  backgroundColor: theme.colorScheme.surface,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('All 100% prerequisite dependency contracts verified. Downstream execution enabled.'),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                child: const Text('PROCEED TO EXECUTION PHASE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
