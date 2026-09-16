// lib/widgets/artifact_publisher_card.dart
// Task GEN-00057: Google Artifact Registry Publication Engine
import 'package:flutter/material.dart';

class ArtifactPublisherCard extends StatefulWidget {
  const ArtifactPublisherCard({super.key});

  @override
  State<ArtifactPublisherCard> createState() => _ArtifactPublisherCardState();
}

class _ArtifactPublisherCardState extends State<ArtifactPublisherCard> {
  bool _isPublishing = false;
  bool _published = false;

  Future<void> _publishPackage() async {
    setState(() => _isPublishing = true);
    await Future.delayed(const Duration(milliseconds: 350));
    setState(() {
      _isPublishing = false;
      _published = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Package: @gacl/ui-core', style: theme.textTheme.titleMedium),
                Chip(
                  label: Text(_published ? 'DEPLOYED' : 'PENDING'),
                  backgroundColor: _published
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.surfaceContainerHighest,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('Target: us-central1-maven.pkg.dev/gacl-enterprise/ui-core-repo'),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: _isPublishing ? null : _publishPackage,
                icon: _isPublishing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.publish),
                label: Text(
                  _isPublishing
                      ? 'PUBLISHING TO ARTIFACT REGISTRY...'
                      : 'PUBLISH @gacl/ui-core PACKAGE',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
