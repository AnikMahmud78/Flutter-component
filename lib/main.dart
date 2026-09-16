// lib/main.dart
// Main test entry for GEN-00370
import 'package:flutter/material.dart';
import 'widgets/build_artifact_lock_banner.dart';
import 'widgets/build_artifact_lock_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GEN-00370 Runner',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                const BuildArtifactLockBanner(status: 'Pass'),
            const BuildArtifactLockCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
