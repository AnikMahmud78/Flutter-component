import 'package:flutter/material.dart';
import '../models/realtime_status_model.dart';

class RealTimeStatusCard extends StatelessWidget {
  final RealTimeStatusModel model;
  final VoidCallback onTriggerDispatch;

  const RealTimeStatusCard({
    Key? key,
    required this.model,
    required this.onTriggerDispatch,
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
            Text('Dispatch Monitor: \${model.dispatchId}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Chip(
                  avatar: const Icon(Icons.flash_on, color: Colors.amber),
                  label: Text('\${model.latencyMs} ms'),
                  backgroundColor: model.latencyMs < 200 ? Colors.green.shade50 : Colors.orange.shade50,
                ),
                const SizedBox(width: 12.0),
                Text('Status: \${model.completionStatus}', style: theme.textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onTriggerDispatch,
                icon: const Icon(Icons.send),
                label: const Text('Test Sub-200ms Dispatch'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
