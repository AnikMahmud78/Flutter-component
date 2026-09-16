// lib/widgets/lookml_dashboard_card.dart
import 'package:flutter/material.dart';

class LookmlDashboardCard extends StatelessWidget {
  const LookmlDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LookML File Definition Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('mobile_executive_dashboard.lkml'),
          subtitle: const Text('Type: Dashboard | Tiles: 6 KPI Elements | Auto-Refresh: 30s'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.code),
            label: const Text('VALIDATE LOOKML SYNTAX'),
          ),
        ),
      ],
    );
  }
}
