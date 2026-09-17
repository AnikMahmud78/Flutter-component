// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/banned_terms_card.dart';
import 'widgets/banned_terms_banner.dart';

void main() {
  runApp(const BannedTermsScreenApp());
}

class BannedTermsScreenApp extends StatelessWidget {
  const BannedTermsScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banned Terminology Dictionary (GEN-00976)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const BannedTermsScreen(),
    );
  }
}

class BannedTermsScreen extends StatelessWidget {
  const BannedTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Banned Terminology Dictionary (GEN-00976)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            BannedTermsBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: BannedTermsCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
