// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/hero_layout_card.dart';
import 'widgets/review_authenticity_banner.dart';

void main() {
  runApp(const HeroLayoutScreenApp());
}

class HeroLayoutScreenApp extends StatelessWidget {
  const HeroLayoutScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Layout Hierarchy (GEN-01145)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HeroLayoutScreen(),
    );
  }
}

class HeroLayoutScreen extends StatelessWidget {
  const HeroLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Layout Hierarchy (GEN-01145)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReviewAuthenticityBanner(status: 'Good', authenticityRate: 0.99),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: HeroLayoutCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
