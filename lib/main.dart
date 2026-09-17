// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/clock_decorator_card.dart';
import 'widgets/pep8_syntax_banner.dart';

void main() {
  runApp(const ClockDecoratorApp());
}

class ClockDecoratorApp extends StatelessWidget {
  const ClockDecoratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock Decorator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const ClockDecoratorScreen(),
    );
  }
}

class ClockDecoratorScreen extends StatelessWidget {
  const ClockDecoratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clock Decorator (GEN-00822)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Pep8SyntaxBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ClockDecoratorCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
