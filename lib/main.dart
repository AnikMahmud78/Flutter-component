// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/capi_logging_card.dart';
import 'widgets/nist_logging_banner.dart';

void main() {
  runApp(const CapiLogApp());
}

class CapiLogApp extends StatelessWidget {
  const CapiLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meta CAPI Logger',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CapiLogScreen(),
    );
  }
}

class CapiLogScreen extends StatelessWidget {
  const CapiLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meta CAPI Logger (GEN-00535)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            NistLoggingBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CapiLoggingCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
