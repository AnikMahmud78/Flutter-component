import 'package:flutter/material.dart';
import '../models/hesitation_monitor_model.dart';

class HesitationMonitorCard extends StatelessWidget {
  final HesitationMonitorModel model;
  final VoidCallback onSimulateHesitation;

  const HesitationMonitorCard({
    Key? key,
    required this.model,
    required this.onSimulateHesitation,
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
            Text('Human Friction Telemetry', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Configured Threshold: > ${model.thresholdSeconds} seconds hover/pause'),
            const SizedBox(height: 8.0),
            Chip(
              avatar: Icon(
                model.isHesitationDetected ? Icons.warning_amber : Icons.check_circle,
                color: model.isHesitationDetected ? Colors.orange : Colors.green,
              ),
              label: Text(model.isHesitationDetected ? 'Hesitation Logged' : 'Normal Interaction'),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onSimulateHesitation,
                icon: const Icon(Icons.timer_3),
                label: const Text('Simulate 5s Focus Pause'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
