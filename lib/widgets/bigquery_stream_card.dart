import 'package:flutter/material.dart';
import '../models/bigquery_stream_model.dart';

class BigQueryStreamCard extends StatelessWidget {
  final BigQueryStreamModel model;
  final VoidCallback onSimulateTileTap;

  const BigQueryStreamCard({
    Key? key,
    required this.model,
    required this.onSimulateTileTap,
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
            Text('BigQuery Streaming Pipeline', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Trace ID: \${model.traceId}', style: theme.textTheme.bodySmall),
            Text('Queued Telemetry Events: \${model.queuedEvents}'),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onSimulateTileTap,
                icon: const Icon(Icons.touch_app),
                label: const Text('Simulate Quick-Action Tile Tap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
