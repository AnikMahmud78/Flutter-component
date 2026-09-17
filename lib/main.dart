// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/addon_exclusion_card.dart';
import 'widgets/addon_attach_rate_banner.dart';

void main() {
  runApp(const AddonExclusionScreenApp());
}

class AddonExclusionScreenApp extends StatelessWidget {
  const AddonExclusionScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutually Exclusive Add-Ons (GEN-01211)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const AddonExclusionScreen(),
    );
  }
}

class AddonExclusionScreen extends StatelessWidget {
  const AddonExclusionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mutually Exclusive Add-Ons (GEN-01211)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AddonAttachRateBanner(status: 'Good', attachRate: 0.25),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: AddonExclusionCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
