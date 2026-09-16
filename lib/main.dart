// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/release_interlock_card.dart';
import 'widgets/interlock_status_banner.dart';

void main() {
  runApp(const ReleaseInterlockApp());
}

class ReleaseInterlockApp extends StatelessWidget {
  const ReleaseInterlockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Release Interlock Gate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const InterlockScreen(),
    );
  }
}

class InterlockScreen extends StatelessWidget {
  const InterlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Release Interlock (GEN-00712)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            InterlockStatusBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ReleaseInterlockCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
