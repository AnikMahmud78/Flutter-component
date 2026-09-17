// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/mobile_funnel_template_card.dart';
import 'widgets/funnel_completion_banner.dart';

void main() {
  runApp(const MobileFunnelTemplateScreenApp());
}

class MobileFunnelTemplateScreenApp extends StatelessWidget {
  const MobileFunnelTemplateScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Funnel Template (GEN-01067)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MobileFunnelTemplateScreen(),
    );
  }
}

class MobileFunnelTemplateScreen extends StatelessWidget {
  const MobileFunnelTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Funnel Template (GEN-01067)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FunnelCompletionBanner(status: 'Good', completionRate: 0.8),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: MobileFunnelTemplateCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
