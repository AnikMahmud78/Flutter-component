// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/bigquery_cluster_card.dart';
import 'widgets/bq_best_practice_banner.dart';

void main() {
  runApp(const BqClusterApp());
}

class BqClusterApp extends StatelessWidget {
  const BqClusterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BigQuery Lineage Clustering',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ClusterScreen(),
    );
  }
}

class ClusterScreen extends StatelessWidget {
  const ClusterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BigQuery Clustering (GEN-00557)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            BqBestPracticeBanner(status: 'Pass', lookupSpeedMs: 142.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: BigQueryClusterCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
