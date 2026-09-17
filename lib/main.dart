// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/touch_ripple_category_card.dart';
import 'widgets/discoverability_time_banner.dart';

void main() {
  runApp(const TouchRippleCategoryScreenApp());
}

class TouchRippleCategoryScreenApp extends StatelessWidget {
  const TouchRippleCategoryScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Touch Ripple Interactions (GEN-01123)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TouchRippleCategoryScreen(),
    );
  }
}

class TouchRippleCategoryScreen extends StatelessWidget {
  const TouchRippleCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Touch Ripple Interactions (GEN-01123)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DiscoverabilityTimeBanner(status: 'Good', timeToFind: '<3s'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TouchRippleCategoryCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
