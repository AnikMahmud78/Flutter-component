// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/post_write_ack_card.dart';
import 'widgets/pipe_filter_status_banner.dart';

void main() {
  runApp(const PubSubAckApp());
}

class PubSubAckApp extends StatelessWidget {
  const PubSubAckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pub/Sub Post-Write Ack',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PubSubAckScreen(),
    );
  }
}

class PubSubAckScreen extends StatelessWidget {
  const PubSubAckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post-Write Ack Protocol (GEN-00491)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PipeFilterStatusBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: PostWriteAckCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
