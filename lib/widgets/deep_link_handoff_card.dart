import 'package:flutter/material.dart';
import '../models/deep_link_handoff_model.dart';

class DeepLinkHandoffCard extends StatelessWidget {
  final DeepLinkHandoffModel model;
  final VoidCallback onTestHandoff;

  const DeepLinkHandoffCard({
    Key? key,
    required this.model,
    required this.onTestHandoff,
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
              'Deep-Link Execution Tester',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Target: \${model.linkUrl}', style: theme.textTheme.bodySmall),
            Text('Platform: \${model.targetPlatform}', style: theme.textTheme.bodySmall),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Chip(
                  avatar: const Icon(Icons.speed, size: 16.0),
                  label: Text('\${model.handoffLatencyMs.toInt()} ms'),
                ),
                const SizedBox(width: 8.0),
                Chip(
                  avatar: const Icon(Icons.location_on, size: 16.0),
                  label: Text('±\${model.pinAccuracyMeters.toStringAsFixed(1)} m'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onTestHandoff,
                icon: const Icon(Icons.phonelink_setup),
                label: const Text('Execute Handoff Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
