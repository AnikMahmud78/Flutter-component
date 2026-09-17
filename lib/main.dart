// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/container_replacement_card.dart';
import 'widgets/auto_replacement_banner.dart';

void main() {
  runApp(const ContainerReplacementScreenApp());
}

class ContainerReplacementScreenApp extends StatelessWidget {
  const ContainerReplacementScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Replacement (GEN-01023)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ContainerReplacementScreen(),
    );
  }
}

class ContainerReplacementScreen extends StatelessWidget {
  const ContainerReplacementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Container Replacement (GEN-01023)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AutoReplacementBanner(status: 'Pass', replacementSecs: 18.4),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ContainerReplacementCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
