// lib/widgets/release_interlock_card.dart
import 'package:flutter/material.dart';

class ReleaseInterlockCard extends StatefulWidget {
  const ReleaseInterlockCard({super.key});

  @override
  State<ReleaseInterlockCard> createState() => _ReleaseInterlockCardState();
}

class _ReleaseInterlockCardState extends State<ReleaseInterlockCard> {
  double _reconciliationScore = 1.0; // Score != 0 triggers interlock lock

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLocked = _reconciliationScore != 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CI/CD Deployment Interlock Gate', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reconciliation Variance Score: ${_reconciliationScore.toStringAsFixed(2)}'),
            ChoiceChip(
              label: Text(isLocked ? 'GATE LOCKED' : 'RELEASE READY'),
              selected: isLocked,
              selectedColor: theme.colorScheme.errorContainer,
              onSelected: (val) {
                setState(() => _reconciliationScore = val ? 1.0 : 0.0);
              },
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48.0),
              backgroundColor: isLocked ? theme.colorScheme.onSurface.withOpacity(0.12) : theme.colorScheme.primary,
              foregroundColor: isLocked ? theme.colorScheme.onSurface.withOpacity(0.38) : theme.colorScheme.onPrimary,
            ),
            onPressed: isLocked
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Released to Tech successfully!')),
                    );
                  },
            icon: const Icon(Icons.rocket_launch),
            label: const Text('RELEASE TO TECH'),
          ),
        ),
      ],
    );
  }
}
