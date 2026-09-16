// lib/main.dart
// Task GEN-00057: Google Artifact Registry Publication Engine
import 'package:flutter/material.dart';
import 'widgets/artifact_publisher_card.dart';
import 'widgets/operational_excellence_banner.dart';

void main() {
  runApp(const ArtifactPublisherApp());
}

class ArtifactPublisherApp extends StatelessWidget {
  const ArtifactPublisherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Artifact Registry Publisher',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const PublisherScreen(),
    );
  }
}

class PublisherScreen extends StatelessWidget {
  const PublisherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artifact Registry Deployment (GEN-00057)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            OperationalExcellenceBanner(status: 'Complete'),
            ArtifactPublisherCard(),
          ],
        ),
      ),
    );
  }
}
