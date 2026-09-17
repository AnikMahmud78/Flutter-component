// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/isolate_serialization_card.dart';
import 'widgets/async_threading_banner.dart';

void main() {
  runApp(const SerializationApp());
}

class SerializationApp extends StatelessWidget {
  const SerializationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolate Serialization',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SerializationScreen(),
    );
  }
}

class SerializationScreen extends StatelessWidget {
  const SerializationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate Worker (GEN-00867)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AsyncThreadingBanner(status: 'Pass', delayMs: 0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: IsolateSerializationCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
