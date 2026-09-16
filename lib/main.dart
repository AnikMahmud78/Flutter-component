// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/push_audit_table_card.dart';
import 'widgets/bq_schema_banner.dart';

void main() {
  runApp(const PushAuditApp());
}

class PushAuditApp extends StatelessWidget {
  const PushAuditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Audit Table',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const AuditTableScreen(),
    );
  }
}

class AuditTableScreen extends StatelessWidget {
  const AuditTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Push Audit DDL (GEN-00701)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            BqSchemaBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: PushAuditTableCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
