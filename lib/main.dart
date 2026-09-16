// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/cloud_sql_resource_card.dart';
import 'widgets/gcp_module_banner.dart';

void main() {
  runApp(const CloudSqlApp());
}

class CloudSqlApp extends StatelessWidget {
  const CloudSqlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud SQL Resource Config',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CloudSqlScreen(),
    );
  }
}

class CloudSqlScreen extends StatelessWidget {
  const CloudSqlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cloud SQL Instance (GEN-00469)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            GcpModuleBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CloudSqlResourceCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
