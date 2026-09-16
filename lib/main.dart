// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/popup_linter_checker.dart';
import 'widgets/maintainability_banner.dart';

void main() {
  runApp(const PopupLinterApp());
}

class PopupLinterApp extends StatelessWidget {
  const PopupLinterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popup Linter Warning Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const PopupLinterScreen(),
    );
  }
}

class PopupLinterScreen extends StatelessWidget {
  const PopupLinterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popup Linter Rule (GEN-00237)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            MaintainabilityBanner(status: 'Pass', complexity: 4),
            PopupLinterChecker(),
          ],
        ),
      ),
    );
  }
}
