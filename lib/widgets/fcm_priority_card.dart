import 'package:flutter/material.dart';
import '../models/fcm_priority_model.dart';

class FcmPriorityCard extends StatelessWidget {
  final FcmPriorityModel model;
  final VoidCallback onTestAlert;

  const FcmPriorityCard({
    Key? key,
    required this.model,
    required this.onTestAlert,
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
            Text('FCM High-Priority Channel', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Channel: \${model.channelId}'),
            const SizedBox(height: 8.0),
            Chip(
              avatar: const Icon(Icons.notifications_active, color: Colors.red),
              label: Text(model.isHighPriority ? 'Lock Screen Pop Enabled' : 'Standard Priority'),
              backgroundColor: Colors.red.shade50,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onTestAlert,
                icon: const Icon(Icons.ring_volume),
                label: const Text('Dispatch High-Priority Alert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
