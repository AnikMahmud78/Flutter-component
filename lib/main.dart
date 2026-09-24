import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/websocket_scorecard.dart';
import 'models/score_event.dart';

void main() {
  runApp(const WsScorecardApp());
}

class WsScorecardApp extends StatefulWidget {
  const WsScorecardApp({Key? key}) : super(key: key);

  @override
  State<WsScorecardApp> createState() => _WsScorecardAppState();
}

class _WsScorecardAppState extends State<WsScorecardApp> {
  final StreamController<ScoreEvent> _streamController = StreamController<ScoreEvent>.broadcast();

  void _pushSimulatedSocketFrame() {
    _streamController.add(ScoreEvent(
      metricKey: 'DORA_DEPLOYMENT',
      score: 99.2,
      grade: 'A+',
      latencyMs: 145,
    ));
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('WebSocket Realtime Scorecard')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              WebsocketScorecard(socketStream: _streamController.stream),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pushSimulatedSocketFrame,
                child: const Text('PUSH WEBSOCKET SCORE EVENT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
