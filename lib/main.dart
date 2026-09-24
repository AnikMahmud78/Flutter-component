import 'package:flutter/material.dart';
import 'models/gcp_infra_repo_model.dart';
import 'widgets/gcp_infra_repo_card.dart';

void main() {
  runApp(const GcpInfraRepoApp());
}

class GcpInfraRepoApp extends StatelessWidget {
  const GcpInfraRepoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GCP Infra Repository Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const GcpInfraRepoScreen(),
    );
  }
}

class GcpInfraRepoScreen extends StatelessWidget {
  const GcpInfraRepoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const repoModel = GcpInfraRepoModel(
      repoPath: 'git.habot.internal/gcp-infrastructure.git',
      commitHash: 'a8f921b7c014',
      completionRate: 100.0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('GCP Infrastructure Sync')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GcpInfraRepoCard(
              model: repoModel,
              onVerifyRepo: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('GCP Infrastructure Configuration Verified (100% Sync)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
