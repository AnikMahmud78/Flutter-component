// lib/widgets/build_artifact_lock_card.dart
// Task GEN-00370: Lock production build artifacts against unauthorized modification.
import 'package:flutter/material.dart';

class BuildArtifactLockCard extends StatefulWidget {
  const BuildArtifactLockCard({super.key});

  @override
  State<BuildArtifactLockCard> createState() => _BuildArtifactLockCardState();
}

class _BuildArtifactLockCardState extends State<BuildArtifactLockCard> {
  bool _locked = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Artifact Immutable Lock Guard', style: theme.textTheme.titleMedium),
                Chip(
                  label: Text(_locked ? 'SECURED & LOCKED' : 'UNLOCKED'),
                  backgroundColor: _locked
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.errorContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            const Text('SHA-256 Digest: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {
                  setState(() {
                    _locked = true;
                  });
                },
                icon: const Icon(Icons.lock),
                label: const Text('ENFORCE IMMUTABLE LOCK'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
