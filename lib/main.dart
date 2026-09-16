// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/trace_header_extractor_card.dart';
import 'widgets/w3c_trace_banner.dart';

void main() {
  runApp(const TraceHeaderApp());
}

class TraceHeaderApp extends StatelessWidget {
  const TraceHeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X-Trace-ID Header Extractor',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TraceScreen(),
    );
  }
}

class TraceScreen extends StatelessWidget {
  const TraceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trace Header Middleware (GEN-00568)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            W3cTraceBanner(status: 'Complete', latencyMs: 0.08),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TraceHeaderExtractorCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
