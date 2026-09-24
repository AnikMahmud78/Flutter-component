import 'package:flutter/material.dart';
import '../models/geofence_feature_model.dart';

class GeofenceStatusCard extends StatelessWidget {
  final GeofenceFeatureModel model;
  final VoidCallback onRefreshLocation;

  const GeofenceStatusCard({
    super.key,
    required this.model,
    required this.onRefreshLocation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Target Zone: ${model.zoneName}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('User Position Status: ${model.isInsideZone ? "INSIDE BOUNDARY" : "OUTSIDE BOUNDARY"}'),
            Text('Feature Unlock State: ${model.featureUnlocked ? "ACTIVE" : "LOCKED"}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onRefreshLocation,
                icon: const Icon(Icons.my_location),
                label: const Text('Ping Location Telemetry'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
