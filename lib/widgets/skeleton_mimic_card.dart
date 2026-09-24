import 'package:flutter/material.dart';
import '../models/skeleton_mimic_model.dart';

class SkeletonMimicCard extends StatelessWidget {
  final SkeletonMimicModel model;
  final VoidCallback onToggleLoading;

  const SkeletonMimicCard({
    Key? key,
    required this.model,
    required this.onToggleLoading,
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
            if (model.isLoading) ...[
              Container(
                height: 20.0,
                width: 180.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                height: 14.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ] else ...[
              Text('Loaded Content Card', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8.0),
              const Text('Data payload hydrated from backend API without layout shift.'),
            ],
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: OutlinedButton(
                onPressed: onToggleLoading,
                child: Text(model.isLoading ? 'Show Loaded State' : 'Simulate Skeleton Loading'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
