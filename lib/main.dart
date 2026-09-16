// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/sql_ingestion_card.dart';
import 'widgets/etl_guidelines_banner.dart';

void main() {
  runApp(const SqlIngestionApp());
}

class SqlIngestionApp extends StatelessWidget {
  const SqlIngestionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQL Identity Ingestion',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const IngestionScreen(),
    );
  }
}

class IngestionScreen extends StatelessWidget {
  const IngestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identity Ingestion (GEN-00656)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            EtlGuidelinesBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SqlIngestionCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
