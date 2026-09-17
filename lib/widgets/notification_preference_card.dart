// lib/widgets/notification_preference_card.dart
import 'package:flutter/material.dart';

class NotificationPreferenceCard extends StatefulWidget {
  const NotificationPreferenceCard({super.key});

  @override
  State<NotificationPreferenceCard> createState() => _NotificationPreferenceCardState();
}

class _NotificationPreferenceCardState extends State<NotificationPreferenceCard> {
  bool _pushNotifications = true;
  bool _emailDigest = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('M3 Preference Group: Notifications', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        SwitchListTile(
          title: const Text('Push Alerts'),
          subtitle: const Text('Instant critical delivery notifications'),
          value: _pushNotifications,
          onChanged: (v) => setState(() => _pushNotifications = v),
        ),
        SwitchListTile(
          title: const Text('Weekly Digest'),
          subtitle: const Text('Summary email report every Monday'),
          value: _emailDigest,
          onChanged: (v) => setState(() => _emailDigest = v),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Preferences saved with GDPR compliance!')),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text('SAVE NOTIFICATION PREFERENCES'),
          ),
        ),
      ],
    );
  }
}
