import 'package:flutter/material.dart';
import 'widgets/token_repository_card.dart';
import 'widgets/export_quality_banner.dart';

void main() {
  runApp(const TokenExportApp());
}

class TokenExportApp extends StatelessWidget {
  const TokenExportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Token Export Repository',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const TokenExportScreen(),
    );
  }
}

class TokenExportScreen extends StatelessWidget {
  const TokenExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Token Export Repo (GEN-00035)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ExportQualityBanner(status: 'Complete'),
            TokenRepositoryCard(),
          ],
        ),
      ),
    );
  }
}
