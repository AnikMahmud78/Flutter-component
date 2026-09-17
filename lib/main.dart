// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/gps_navigation_card.dart';
import 'widgets/map_pin_accuracy_banner.dart';

void main() {
  runApp(const GpsNavigationScreenApp());
}

class GpsNavigationScreenApp extends StatelessWidget {
  const GpsNavigationScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Navigation Binding (GEN-01178)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const GpsNavigationScreen(),
    );
  }
}

class GpsNavigationScreen extends StatelessWidget {
  const GpsNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Navigation Binding (GEN-01178)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            MapPinAccuracyBanner(status: 'Good', accuracy: '±10m / <500ms'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: GpsNavigationCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
