import 'package:flutter/material.dart';
import '../models/fulfillment_bi_model.dart';

class FulfillmentBiCard extends StatelessWidget {
  final FulfillmentBiModel model;
  final VoidCallback onRefresh;

  const FulfillmentBiCard({
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
            Text('Fulfillment Operations BI', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Avg Fulfillment: \${model.avgFulfillmentHours.toStringAsFixed(1)} hrs'),
                Text('Transition: \${model.transitionSpeedSeconds.toStringAsFixed(1)}s'),
              ],
            ),
            const SizedBox(height: 8.0),
            Chip(
              label: Text('Bottlenecks Identified: \${model.activeBottlenecks}'),
              backgroundColor: model.activeBottlenecks == 0 ? Colors.green.shade50 : Colors.amber.shade50,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.analytics),
                label: const Text('Refresh Operational Metrics'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
