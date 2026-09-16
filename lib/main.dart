// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/function_length_checker.dart';
import 'widgets/tki3_constraint_banner.dart';

void main() {
  runApp(const CodeConstraintApp());
}

class CodeConstraintApp extends StatelessWidget {
  const CodeConstraintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atomic Code Constraint',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ConstraintScreen(),
    );
  }
}

class ConstraintScreen extends StatelessWidget {
  const ConstraintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Code Constraint (GEN-00414)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Tki3ConstraintBanner(status: 'Pass', maxLines: 20),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FunctionLengthChecker(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
