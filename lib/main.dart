// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/triangular_check_decorator.dart';
import 'widgets/pep318_syntax_banner.dart';

void main() {
  runApp(const DecoratorApp());
}

class DecoratorApp extends StatelessWidget {
  const DecoratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Triangular Check Decorator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const DecoratorScreen(),
    );
  }
}

class DecoratorScreen extends StatelessWidget {
  const DecoratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Triangular Decorator (GEN-00425)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Pep318SyntaxBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TriangularCheckDecoratorWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
