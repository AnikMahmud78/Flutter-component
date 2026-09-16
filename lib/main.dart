// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/skan_model_card.dart';
import 'widgets/dmbok2_skan_banner.dart';

void main() {
  runApp(const SkanModelApp());
}

class SkanModelApp extends StatelessWidget {
  const SkanModelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SKAN Probabilistic Model',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SkanScreen(),
    );
  }
}

class SkanScreen extends StatelessWidget {
  const SkanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SKAN Attribution (GEN-00778)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Dmbok2SkanBanner(rating: 'High', fitPct: 0.962),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SkanModelCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
