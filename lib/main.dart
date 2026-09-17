// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/deep_link_nav_card.dart';
import 'widgets/ux_responsiveness_banner.dart';

void main() {
  runApp(const DeepLinkNavApp());
}

class DeepLinkNavApp extends StatelessWidget {
  const DeepLinkNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instant Deep Link Navigation',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NavScreen(),
    );
  }
}

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deep Link Router (GEN-00890)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            UxResponsivenessBanner(status: 'Pass', launchMs: 76.2),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DeepLinkNavCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
