import 'package:flutter/material.dart';
import '../models/task_time_gate_model.dart';

class TaskTimeGateCard extends StatelessWidget {
  final TaskTimeGateModel model;
  final VoidCallback onCheckTimer;

  const TaskTimeGateCard({
    Key? key,
    required this.model,
    required this.onCheckTimer,
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
            Text('Task Physical Time Enforcer', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Max Allowed Duration: ${model.maxTaskSeconds} seconds'),
            Text('Elapsed Task Time: ${model.elapsedSeconds} seconds'),
            const SizedBox(height: 8.0),
            Chip(
              avatar: Icon(
                model.isTimeExceeded ? Icons.timer_off : Icons.timer,
                color: model.isTimeExceeded ? Colors.red : Colors.green,
              ),
              label: Text(model.isTimeExceeded ? 'Time Cap Exceeded (Auto-Escalate)' : 'Within Time Boundary'),
              backgroundColor: model.isTimeExceeded ? Colors.red.shade50 : Colors.green.shade50,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onCheckTimer,
                child: const Text('Enforce Time Cap Boundary'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
