// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/utm_injector_card.dart';
import 'widgets/rfc3986_utm_banner.dart';

void main() {
  runApp(const UtmInjectorApp());
}

class UtmInjectorApp extends StatelessWidget {
  const UtmInjectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTM Link Shortener',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const UtmScreen(),
    );
  }
}

class UtmScreen extends StatelessWidget {
  const UtmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UTM Injector (GEN-00800)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Rfc3986UtmBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: UtmInjectorCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
