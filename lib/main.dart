// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/design_token_compilation_card.dart';
import 'widgets/token_compilation_banner.dart';

void main() {
  runApp(const DesignTokenCompilationScreenApp());
}

class DesignTokenCompilationScreenApp extends StatelessWidget {
  const DesignTokenCompilationScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Token Compiler (GEN-01045)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DesignTokenCompilationScreen(),
    );
  }
}

class DesignTokenCompilationScreen extends StatelessWidget {
  const DesignTokenCompilationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design Token Compiler (GEN-01045)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TokenCompilationBanner(status: 'Pass', successRate: 1.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DesignTokenCompilationCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
