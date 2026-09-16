// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/mta_identity_join_card.dart';
import 'widgets/dmbok2_identity_banner.dart';

void main() {
  runApp(const MtaIdentityApp());
}

class MtaIdentityApp extends StatelessWidget {
  const MtaIdentityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTA Identity Resolution Pipeline',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MtaScreen(),
    );
  }
}

class MtaScreen extends StatelessWidget {
  const MtaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MTA Identity Join (GEN-00645)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Dmbok2IdentityBanner(status: 'Pass', joinRate: 0.985),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: MtaIdentityJoinCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
