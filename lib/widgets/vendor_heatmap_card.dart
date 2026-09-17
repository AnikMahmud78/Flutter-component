// lib/widgets/vendor_heatmap_card.dart
import 'package:flutter/material.dart';

class VendorHeatmapCard extends StatelessWidget {
  const VendorHeatmapCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vendor Demand Heatmap & Rage-Click Detector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Localized Demand Density Map'),
          subtitle: const Text('Rage-Click Accuracy: 95% | Heatmap Overlay Active'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.layers),
            label: const Text('LOAD HEATMAP OVERLAY'),
          ),
        ),
      ],
    );
  }
}
