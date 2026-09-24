import 'package:flutter/material.dart';
import '../models/triangular_check_model.dart';

class TriangularCheckCard extends StatelessWidget {
  final TriangularCheckModel model;
  final VoidCallback onRunCheck;

  const TriangularCheckCard({
    Key? key,
    required this.model,
    required this.onRunCheck,
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
              'Client-Side Triangular Gate',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),
            Text('Subtotal (A): \$${model.sideA.toStringAsFixed(2)}'),
            Text('Tax/Fees (B): \$${model.sideB.toStringAsFixed(2)}'),
            Text('Total (C): \$${model.totalC.toStringAsFixed(2)}'),
            const SizedBox(height: 12.0),
            Chip(
              avatar: Icon(
                model.isBalanced ? Icons.check_circle : Icons.error,
                color: model.isBalanced ? Colors.green : Colors.red,
              ),
              label: Text(model.isBalanced ? 'Balanced (Pass)' : 'Mismatched (Block)'),
              backgroundColor: model.isBalanced ? Colors.green.shade50 : Colors.red.shade50,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onRunCheck,
                child: const Text('Execute Triangular Balance Check'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
