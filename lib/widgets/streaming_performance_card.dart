import 'package:flutter/material.dart';
import '../models/video_3g_playback_model.dart';

class StreamingPerformanceCard extends StatelessWidget {
  final Video3gPlaybackModel model;
  final VoidCallback onTestPlayback;

  const StreamingPerformanceCard({
    super.key,
    required this.model,
    required this.onTestPlayback,
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
            Text('Target URI: ${model.mediaUrl}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8.0),
            Text('3G Time to First Frame: ${model.startupLatencyMs} ms', style: theme.textTheme.bodyLarge),
            Text('Playback Status Level: ${model.health.name.toUpperCase()}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onTestPlayback,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Trigger 3G Instant Load Test'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
