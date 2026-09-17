// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/vendor_heatmap_card.dart';
import 'widgets/rage_click_accuracy_banner.dart';

void main() {
  runApp(const VendorHeatmapScreenApp());
}

class VendorHeatmapScreenApp extends StatelessWidget {
  const VendorHeatmapScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vendor Heatmap Analytics (GEN-01078)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const VendorHeatmapScreen(),
    );
  }
}

class VendorHeatmapScreen extends StatelessWidget {
  const VendorHeatmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendor Heatmap Analytics (GEN-01078)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            RageClickAccuracyBanner(status: 'Good', accuracy: 0.95),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: VendorHeatmapCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
