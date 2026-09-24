import 'package:flutter/material.dart';
import '../models/uri_context_model.dart';

class UriContextCard extends StatelessWidget {
  final UriContextModel model;
  final VoidCallback onParseNewUri;

  const UriContextCard({
    super.key,
    required this.model,
    required this.onParseNewUri,
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
            Text('Raw URI: ${model.rawUri}', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8.0),
            Text('Extracted Task ID: ${model.taskId}'),
            Text('Extracted Trace ID: ${model.traceId}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onParseNewUri,
                icon: const Icon(Icons.link),
                label: const Text('Parse URI Deep-Link Context'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
