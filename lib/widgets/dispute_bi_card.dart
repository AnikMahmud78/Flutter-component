import 'package:flutter/material.dart';
import '../models/dispute_bi_model.dart';

class DisputeBiCard extends StatelessWidget {
  final DisputeBiModel model;
  final VoidCallback onRefresh;

  const DisputeBiCard({
    Key? key,
    required this.model,
    required this.onRefresh,
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
            Text('Dispute Resolution BI', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Text('Active Claims: \${model.totalDisputes}'),
            Text('Highest Volume Category: \${model.topCategory}'),
            const SizedBox(height: 8.0),
            Chip(
              label: Text('Avg Cycle Time: \${model.resolutionCycleHours} hrs'),
              backgroundColor: model.completionStatus == 'Good' ? Colors.green.shade50 : Colors.amber.shade50,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: OutlinedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh ODR Analytics'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
