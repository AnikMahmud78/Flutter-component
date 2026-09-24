import 'package:flutter/material.dart';
import '../models/npm_publisher_model.dart';

class NpmpublisherCard extends StatelessWidget {
  final NpmpublisherModel model;
  final VoidCallback onPublishPackage;

  const NpmpublisherCard({
    Key? key,
    required this.model,
    required this.onPublishPackage,
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
            Text('Private Registry Publisher', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Package: ${model.packageName}'),
            Text('SemVer Version: v${model.semverVersion}'),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onPublishPackage,
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Publish to Artifactory Registry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
