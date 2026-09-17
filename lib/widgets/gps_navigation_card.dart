// lib/widgets/gps_navigation_card.dart
import 'package:flutter/material.dart';

class GpsNavigationCard extends StatelessWidget {
  const GpsNavigationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('GPS Navigation Launch Engine', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.location_on, color: theme.colorScheme.primary),
          title: const Text('Habot HQ, Dubai'),
          subtitle: const Text('Pin Accuracy: ±10m | Load Time: <500ms'),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Launching native GPS navigation app...')),
              );
            },
            icon: const Icon(Icons.directions),
            label: const Text('GET DIRECTIONS'),
          ),
        ),
      ],
    );
  }
}
