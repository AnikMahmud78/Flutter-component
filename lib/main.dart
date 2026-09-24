import 'package:flutter/material.dart';
import 'models/video_3g_playback_model.dart';
import 'services/hls_network_simulator.dart';
import 'widgets/streaming_performance_card.dart';
import 'widgets/latency_metric_banner.dart';

void main() {
  runApp(const HABOT3gVideoApp());
}

class HABOT3gVideoApp extends StatelessWidget {
  const HABOT3gVideoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10170GEN-01938 3G Video Playback',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7D5260)),
      ),
      home: const Video3gScreen(),
    );
  }
}

class Video3gScreen extends StatefulWidget {
  const Video3gScreen({super.key});

  @override
  State<Video3gScreen> createState() => _Video3gScreenState();
}

class _Video3gScreenState extends State<Video3gScreen> {
  late Video3gPlaybackModel _model;

  @override
  void initState() {
    super.initState();
    _runTest();
  }

  void _runTest() {
    setState(() {
      _model = HlsNetworkSimulator.evaluate3gPlayback(
        taskId: '10170GEN-01938',
        mediaUrl: 'https://cdn.habot.io/sops/stream_01938.m3u8',
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3G Instant Playback Verifier')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LatencyMetricBanner(successRate: _model.playbackSuccessRate),
            const SizedBox(height: 16.0),
            StreamingPerformanceCard(model: _model, onTestPlayback: _runTest),
          ],
        ),
      ),
    );
  }
}
