// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/release_record_card.dart';
import 'widgets/ed_lock_banner.dart';

void main() {
  runApp(const EdLockVerificationScreenApp());
}

class EdLockVerificationScreenApp extends StatelessWidget {
  const EdLockVerificationScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ED Lock Verification (GEN-01034)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const EdLockVerificationScreen(),
    );
  }
}

class EdLockVerificationScreen extends StatelessWidget {
  const EdLockVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ED Lock Verification (GEN-01034)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            EdLockBanner(status: 'Pass', writeStatus: 'Committed'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ReleaseRecordCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
