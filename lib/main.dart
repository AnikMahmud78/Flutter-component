// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/journey_funnel_card.dart';
import 'widgets/ga4_funnel_banner.dart';

void main() {
  runApp(const JourneyFunnelApp());
}

class JourneyFunnelApp extends StatelessWidget {
  const JourneyFunnelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Journey Funnel',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const FunnelScreen(),
    );
  }
}

class FunnelScreen extends StatelessWidget {
  const FunnelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Journey Funnel (GEN-00912)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Ga4FunnelBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: JourneyFunnelCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
