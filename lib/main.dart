// lib/main.dart
// Task GEN-00079: Build LockableFormContainer Component
import 'package:flutter/material.dart';
import 'widgets/lockable_form_container.dart';
import 'widgets/reliability_status_banner.dart';

void main() {
  runApp(const LockableFormApp());
}

class LockableFormApp extends StatelessWidget {
  const LockableFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lockable Form Container',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LockableScreen(),
    );
  }
}

class LockableScreen extends StatelessWidget {
  const LockableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LockableFormContainer (GEN-00079)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReliabilityStatusBanner(status: 'Pass', rtoSeconds: 1),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: LockableFormContainer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
