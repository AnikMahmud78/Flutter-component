// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/promo_roi_card.dart';
import 'widgets/pci_redemption_banner.dart';

void main() {
  runApp(const PromoRoiScreenApp());
}

class PromoRoiScreenApp extends StatelessWidget {
  const PromoRoiScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Promo ROI Dashboard (GEN-01222)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const PromoRoiScreen(),
    );
  }
}

class PromoRoiScreen extends StatelessWidget {
  const PromoRoiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Promo ROI Dashboard (GEN-01222)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PciRedemptionBanner(status: 'Pass', accuracy: 0.999),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: PromoRoiCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
