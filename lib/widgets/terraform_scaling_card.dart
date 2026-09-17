// lib/widgets/terraform_scaling_card.dart
import 'package:flutter/material.dart';

class TerraformScalingCard extends StatelessWidget {
  const TerraformScalingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cloud Run Terraform Settings Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Resource: google_cloud_run_v2_service'),
          subtitle: const Text('min_instances = 1 | max_instances = 100'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.settings),
            label: const Text('VERIFY TERRAFORM BOUNDARIES'),
          ),
        ),
      ],
    );
  }
}
