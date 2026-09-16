import 'package:flutter/material.dart';
import 'widgets/backtrack_buffer_sync.dart';
import 'widgets/sync_telemetry_banner.dart';

void main() {
  runApp(const BufferSyncApp());
}

class BufferSyncApp extends StatelessWidget {
  const BufferSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backtrack Buffer Sync',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const BufferSyncScreen(),
    );
  }
}

class BufferSyncScreen extends StatelessWidget {
  const BufferSyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network Buffer Sync (FLADE-006-11)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SyncTelemetryBanner(status: 'Good (100%)', qualityScore: 1.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: BacktrackBufferSync(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
