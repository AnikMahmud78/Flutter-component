// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/optimistic_ui_card.dart';
import 'widgets/api_sync_rate_banner.dart';

void main() {
  runApp(const OptimisticUiScreenApp());
}

class OptimisticUiScreenApp extends StatelessWidget {
  const OptimisticUiScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optimistic UI Engine (GEN-01056)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const OptimisticUiScreen(),
    );
  }
}

class OptimisticUiScreen extends StatelessWidget {
  const OptimisticUiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Optimistic UI Engine (GEN-01056)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ApiSyncRateBanner(status: 'Pass', syncRate: 0.999),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: OptimisticUiCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
