import 'package:flutter/material.dart';
import '../models/local_execution_model.dart';

class LocalLogicCard extends StatelessWidget {
  final LocalExecutionModel model;
  final VoidCallback onExecute;

  const LocalLogicCard({
    super.key,
    required this.model,
    required this.onExecute,
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
            Text('Execution Context: JS/Dart Browser App State', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Local Execution Success: ${model.executedLocally ? "YES" : "NO"}'),
            Text('Computation Time: ${model.executionTimeMs.toStringAsFixed(3)} ms'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onExecute,
                icon: const Icon(Icons.flash_on),
                label: const Text('Execute Local Calculation'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
