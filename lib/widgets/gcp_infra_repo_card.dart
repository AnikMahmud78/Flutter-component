import 'package:flutter/material.dart';
import '../models/gcp_infra_repo_model.dart';

class GcpInfraRepoCard extends StatelessWidget {
  final GcpInfraRepoModel model;
  final VoidCallback onVerifyRepo;

  const GcpInfraRepoCard({
    Key? key,
    required this.model,
    required this.onVerifyRepo,
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
            Text('GCP Infra Repo Storage', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Repository: ${model.repoPath}'),
            Text('Commit Hash: ${model.commitHash}'),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onVerifyRepo,
                icon: const Icon(Icons.folder_special),
                label: const Text('Verify Git Sync Status'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
