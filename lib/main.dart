import 'package:flutter/material.dart';
import 'widgets/execution_proof_card.dart';
import 'widgets/governance_status_banner.dart';

void main() {
  runApp(const ExecutionProofApp());
}

class ExecutionProofApp extends StatelessWidget {
  const ExecutionProofApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Execution Proof Verification',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ProofScreen(),
    );
  }
}

class ProofScreen extends StatelessWidget {
  const ProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Execution Proof (GEN-00002)')),
      body: RefreshIndicator(
        onRefresh: () async => await Future.delayed(const Duration(milliseconds: 300)),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const GovernanceStatusBanner(status: 'Complete'),
              ExecutionProofCard(onRefresh: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
