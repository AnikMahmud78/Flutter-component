// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/deferred_deep_link_card.dart';
import 'widgets/deferred_routing_banner.dart';

void main() {
  runApp(const DeferredDeepLinkScreenApp());
}

class DeferredDeepLinkScreenApp extends StatelessWidget {
  const DeferredDeepLinkScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deferred Deep Link (GEN-01001)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DeferredDeepLinkScreen(),
    );
  }
}

class DeferredDeepLinkScreen extends StatelessWidget {
  const DeferredDeepLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deferred Deep Link (GEN-01001)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DeferredRoutingBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DeferredDeepLinkCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
