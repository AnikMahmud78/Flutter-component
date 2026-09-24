import 'dart:async';
import 'package:flutter/material.dart';
import '../models/score_event.dart';

class WebsocketScorecard extends StatefulWidget {
  final Stream<ScoreEvent> socketStream;

  const WebsocketScorecard({Key? key, required this.socketStream}) : super(key: key);

  @override
  State<WebsocketScorecard> createState() => _WebsocketScorecardState();
}

class _WebsocketScorecardState extends State<WebsocketScorecard> {
  double _score = 98.4;
  String _grade = 'A+';
  int _lastLatency = 120;
  late StreamSubscription<ScoreEvent> _sub;

  @override
  void initState() {
    super.initState();
    // English Code (EC): Connect-Scorecard-Websocket-Stream
    _sub = widget.socketStream.listen((event) {
      setState(() {
        _score = event.score;
        _grade = event.grade;
        _lastLatency = event.latencyMs;
      });
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.speed, size: 36, color: Colors.blue),
              title: const Text('Real-Time System Scorecard'),
              subtitle: Text('WebSocket Latency: ${_lastLatency}ms'),
              trailing: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: Text(_grade, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Current Quality Score: ${_score.toStringAsFixed(1)} / 100',
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
