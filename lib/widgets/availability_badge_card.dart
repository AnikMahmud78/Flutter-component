import 'package:flutter/material.dart';
import '../models/availability_badge_model.dart';

class AvailabilityBadgeCard extends StatelessWidget {
  final AvailabilityBadgeModel model;
  final VoidCallback onToggleStatus;

  const AvailabilityBadgeCard({
    Key? key,
    required this.model,
    required this.onToggleStatus,
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Provider Availability', style: theme.textTheme.titleMedium),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: model.isAvailable ? Colors.green.shade100 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10.0,
                        color: model.isAvailable ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        model.statusText,
                        style: TextStyle(
                          color: model.isAvailable ? Colors.green.shade900 : Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: OutlinedButton(
                onPressed: onToggleStatus,
                child: const Text('Toggle Availability Indicator'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
