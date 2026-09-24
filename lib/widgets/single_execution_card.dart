import 'package:flutter/material.dart';
import '../models/single_execution_model.dart';

class SingleExecutionCard extends StatelessWidget {
  final SingleExecutionModel model;
  final VoidCallback onTriggerFirstRun;

  const SingleExecutionCard({
    Key? key,
    required this.model,
    required this.onTriggerFirstRun,
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
            Text('First-Run Setup Lock', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Chip(
              avatar: Icon(
                model.hasExecuted ? Icons.lock : Icons.lock_open,
                color: model.hasExecuted ? Colors.green : Colors.orange,
              ),
              label: Text(model.hasExecuted ? 'Initialization Locked' : 'Pending First Run'),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: model.hasExecuted ? null : onTriggerFirstRun,
                child: const Text('Execute Unique Installation Initializer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
