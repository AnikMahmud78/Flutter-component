import 'package:flutter/material.dart';
import '../models/websocket_badge_model.dart';

class WebSocketBadgeCard extends StatelessWidget {
  final WebSocketBadgeModel model;
  final VoidCallback onSimulateMessage;

  const WebSocketBadgeCard({
    Key? key,
    required this.model,
    required this.onSimulateMessage,
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Real-Time Message Center', style: theme.textTheme.titleMedium),
                Badge(
                  label: Text('\${model.unreadCount}'),
                  backgroundColor: theme.colorScheme.error,
                  child: const Icon(Icons.notifications, size: 32.0),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onSimulateMessage,
                icon: const Icon(Icons.rss_feed),
                label: const Text('Simulate WebSocket Message'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
