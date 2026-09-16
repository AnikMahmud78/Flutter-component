// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/friction_event_logger.dart';
import 'widgets/friction_schema_banner.dart';

void main() {
  runApp(const FrictionLogApp());
}

class FrictionLogApp extends StatelessWidget {
  const FrictionLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UX Friction Event Logger',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const FrictionLogScreen(),
    );
  }
}

class FrictionLogScreen extends StatelessWidget {
  const FrictionLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friction Telemetry (GEN-00634)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FrictionSchemaBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FrictionEventLogger(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
