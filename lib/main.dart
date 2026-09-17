// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/multi_cart_card.dart';
import 'widgets/cart_integrity_banner.dart';

void main() {
  runApp(const MultiCartScreenApp());
}

class MultiCartScreenApp extends StatelessWidget {
  const MultiCartScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Item Cart (GEN-01233)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MultiCartScreen(),
    );
  }
}

class MultiCartScreen extends StatelessWidget {
  const MultiCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi-Item Cart (GEN-01233)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CartIntegrityBanner(status: 'Pass', integrityRate: 0.999),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: MultiCartCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
