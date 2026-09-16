// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/meta_token_verifier_card.dart';
import 'widgets/meta_api_banner.dart';

void main() {
  runApp(const MetaTokenApp());
}

class MetaTokenApp extends StatelessWidget {
  const MetaTokenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meta Token Verifier',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const MetaTokenScreen(),
    );
  }
}

class MetaTokenScreen extends StatelessWidget {
  const MetaTokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meta CAPI Token (GEN-00524)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            MetaApiBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: MetaTokenVerifierCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
