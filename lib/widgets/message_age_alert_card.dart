import 'package:flutter/material.dart';
import '../models/message_age_alert_model.dart';

class MessageAgeAlertCard extends StatelessWidget {
  final MessageAgeAlertModel model;
  final VoidCallback onTriggerPoll;

  const MessageAgeAlertCard({
    Key? key,
    required this.model,
    required this.onTriggerPoll,
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
            Text(
              'Message Queue SLA Monitor',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Topic: ${model.queueTopic}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Max Message Age:', style: theme.textTheme.bodyMedium),
                Chip(
                  avatar: const Icon(Icons.timer, size: 16.0),
                  label: Text('${model.maxUnacknowledgedAgeSeconds}s (${model.completionStatus})'),
                  backgroundColor: model.completionStatus == 'Good'
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onTriggerPoll,
                icon: const Icon(Icons.refresh),
                label: const Text('Poll Queue Health'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
