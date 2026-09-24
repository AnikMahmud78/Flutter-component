import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/realtime_badge.dart';
import 'models/badge_event.dart';

void main() {
  runApp(const RealtimeBadgeApp());
}

class RealtimeBadgeApp extends StatefulWidget {
  const RealtimeBadgeApp({Key? key}) : super(key: key);

  @override
  State<RealtimeBadgeApp> createState() => _RealtimeBadgeAppState();
}

class _RealtimeBadgeAppState extends State<RealtimeBadgeApp> {
  final StreamController<BadgeEvent> _controller = StreamController<BadgeEvent>.broadcast();
  int _counter = 1;

  void _simulateIncomingPush() {
    _controller.add(BadgeEvent(
      count: _counter++,
      category: 'ALERTS',
      timestamp: DateTime.now(),
    ));
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Realtime Badge Telemetry'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: RealtimeBadgeCounter(eventStream: _controller.stream),
            ),
          ],
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _simulateIncomingPush,
            child: const Text('SIMULATE FCM INCOMING PUSH EVENT'),
          ),
        ),
      ),
    );
  }
}
