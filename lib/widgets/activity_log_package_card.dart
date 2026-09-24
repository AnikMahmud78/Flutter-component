import 'package:flutter/material.dart';
import '../models/activity_log_package_model.dart';

class ActivityLogPackageCard extends StatelessWidget {
  final ActivityLogPackageModel model;
  final VoidCallback onInspectModule;

  const ActivityLogPackageCard({
    Key? key,
    required this.model,
    required this.onInspectModule,
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
            Text('Package: @habot/modules/activity-log', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Data Completeness: \${(model.completenessScore * 100).toStringAsFixed(1)}%'),
            const SizedBox(height: 8.0),
            Chip(
              label: Text('Status: \${model.completionStatus}'),
              backgroundColor: Colors.blue.shade50,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onInspectModule,
                child: const Text('Inspect Activity Log Package'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
