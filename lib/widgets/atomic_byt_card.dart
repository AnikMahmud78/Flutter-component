import 'package:flutter/material.dart';
import '../models/atomic_byt_model.dart';

class AtomicBytCard extends StatelessWidget {
  final AtomicBytModel model;
  final VoidCallback onInspectByt;

  const AtomicBytCard({
    Key? key,
    required this.model,
    required this.onInspectByt,
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
            Text('Atomic Component (Byt): ${model.bytName}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Chip(
              avatar: const Icon(Icons.code, color: Colors.blue),
              label: Text(model.isAtomicCompliant ? 'Single Concern (Compliant)' : 'Monolithic Warning'),
              backgroundColor: Colors.blue.shade50,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onInspectByt,
                child: const Text('Inspect Byt Structure'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
