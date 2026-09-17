// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/precommit_abort_card.dart';
import 'widgets/precommit_abort_banner.dart';

void main() {
  runApp(const PrecommitAbortScreenApp());
}

class PrecommitAbortScreenApp extends StatelessWidget {
  const PrecommitAbortScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pre-Commit Abort Hook (GEN-00979)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const PrecommitAbortScreen(),
    );
  }
}

class PrecommitAbortScreen extends StatelessWidget {
  const PrecommitAbortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pre-Commit Abort Hook (GEN-00979)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PrecommitAbortBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: PrecommitAbortCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
