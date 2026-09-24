import 'package:flutter/material.dart';
import '../models/package_commit_manifest.dart';

class DashboardBytComponent extends StatelessWidget {
  final PackageCommitManifest manifest;

  const DashboardBytComponent({Key? key, required this.manifest}) : super(key: key);

  // English Code (EC): Render-Dashboard-Byt-Library-Widget
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.widgets, size: 32, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Text('Engineering Dashboard Byt', style: theme.textTheme.headlineSmall),
              ],
            ),
            const Divider(height: 24),
            Text('Registered Component: ${manifest.componentName}'),
            Text('Target Library: ${manifest.libraryTarget}'),
            Text('Version Commit Tag: ${manifest.versionTag}'),
            const SizedBox(height: 16),
            Chip(
              avatar: const Icon(Icons.cloud_done, color: Colors.white),
              label: const Text('COMMITTED TO DESIGN SYSTEM', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade700,
            ),
          ],
        ),
      ),
    );
  }
}
