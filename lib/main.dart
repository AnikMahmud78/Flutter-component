// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/card_focus_advance_card.dart';
import 'widgets/pci_tokenization_banner.dart';

void main() {
  runApp(const CardFocusAdvanceScreenApp());
}

class CardFocusAdvanceScreenApp extends StatelessWidget {
  const CardFocusAdvanceScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Auto-Advance Focus (GEN-01244)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CardFocusAdvanceScreen(),
    );
  }
}

class CardFocusAdvanceScreen extends StatelessWidget {
  const CardFocusAdvanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Auto-Advance Focus (GEN-01244)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PciTokenizationBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CardFocusAdvanceCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
