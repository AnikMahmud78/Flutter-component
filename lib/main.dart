// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/sync_dedup_card.dart';
import 'widgets/bq_dedup_banner.dart';

void main() {
  runApp(const SyncDedupApp());
}

class SyncDedupApp extends StatelessWidget {
  const SyncDedupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sync Dedup Table DDL',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const SyncDedupScreen(),
    );
  }
}

class SyncDedupScreen extends StatelessWidget {
  const SyncDedupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sync Dedup Table (GEN-00767)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            BqDedupBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SyncDedupCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
