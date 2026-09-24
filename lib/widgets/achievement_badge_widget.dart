import 'package:flutter/material.dart';
import '../models/achievement_badge_model.dart';

class AchievementBadgeWidget extends StatelessWidget {
  final AchievementBadgeModel model;

  const AchievementBadgeWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(Icons.workspace_premium, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.badgeTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text('Tier: \${model.tier.name.toUpperCase()}', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 4.0),
                  Text(model.description, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
