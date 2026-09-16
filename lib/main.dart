// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/schema_text_field.dart';
import 'widgets/clean_code_banner.dart';

void main() {
  runApp(const SchemaMaskApp());
}

class SchemaMaskApp extends StatelessWidget {
  const SchemaMaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schema Input Masking',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const SchemaMaskScreen(),
    );
  }
}

class SchemaMaskScreen extends StatelessWidget {
  const SchemaMaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Masking (GEN-00623)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CleanCodeBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SchemaTextField(label: 'Poka-Yoke Date Field'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
