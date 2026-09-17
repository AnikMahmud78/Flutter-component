// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/dbt_path_access_card.dart';
import 'widgets/dbt_layout_banner.dart';

void main() {
  runApp(const DbtAccessApp());
}

class DbtAccessApp extends StatelessWidget {
  const DbtAccessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dbt Repository Access',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DbtScreen(),
    );
  }
}

class DbtScreen extends StatelessWidget {
  const DbtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('dbt Repository (GEN-00923)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DbtLayoutBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DbtPathAccessCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
