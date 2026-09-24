import 'package:flutter/material.dart';
import '../models/viewport_bounds_model.dart';

class ViewportBoundsCard extends StatelessWidget {
  final ViewportBoundsModel model;
  final VoidCallback onValidateBounds;

  const ViewportBoundsCard({
    Key? key,
    required this.model,
    required this.onValidateBounds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Active Window Viewport Monitor',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active Bounds:', style: theme.textTheme.bodyMedium),
                Text(
                  '${model.windowWidthDp.toStringAsFixed(1)} x ${model.windowHeightDp.toStringAsFixed(1)} dp',
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('M3 Window Class:', style: theme.textTheme.bodyMedium),
                Chip(
                  label: Text(model.windowSizeClass),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onValidateBounds,
                icon: const Icon(Icons.aspect_ratio),
                label: const Text('Validate Active Window Bounds'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
