import 'package:flutter/material.dart';
import '../models/notification_prompt_model.dart';

class NotificationPromptCard extends StatelessWidget {
  final NotificationPromptModel model;
  final VoidCallback onOpenPreferences;

  const NotificationPromptCard({
    Key? key,
    required this.model,
    required this.onOpenPreferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2.0,
      color: theme.colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.tune, color: theme.colorScheme.primary),
                const SizedBox(width: 8.0),
                Text('Notification Preferences', style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('Current pace: \${model.frequencySetting}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: TextButton(
                onPressed: onOpenPreferences,
                child: const Text('Adjust Frequency Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
