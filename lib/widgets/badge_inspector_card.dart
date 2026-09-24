import 'package:flutter/material.dart';
import '../models/badge_config_model.dart';
import 'compact_security_badge.dart';

class BadgeInspectorCard extends StatelessWidget {
  final BadgeConfigModel config;
  final VoidCallback onTrigger;

  const BadgeInspectorCard({
    Key? key,
    required this.config,
    required this.onTrigger,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mobile Security Badge Standards', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Live Indicator: '),
                CompactSecurityBadge(
                  label: config.statusText,
                  onTap: onTrigger,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Configured Height: ${config.badgeHeight} dp'),
            Text('Effective Touch Target: ${config.touchTargetSize}x${config.touchTargetSize} dp'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Validation: ${config.validationResult}',
                style: TextStyle(
                  color: config.validationResult == 'Pass' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
