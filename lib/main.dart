// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/aasa_hosting_card.dart';
import 'widgets/apple_hosting_banner.dart';

void main() {
  runApp(const AasaApp());
}

class AasaApp extends StatelessWidget {
  const AasaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AASA Hosting Checker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const AasaScreen(),
    );
  }
}

class AasaScreen extends StatelessWidget {
  const AasaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AASA Hosting (GEN-00513)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppleHostingBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: AasaHostingCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
