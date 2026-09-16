// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/scaffold_header_timer.dart';
import 'widgets/m3_timer_banner.dart';

void main() {
  runApp(const HeaderTimerApp());
}

class HeaderTimerApp extends StatelessWidget {
  const HeaderTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Header Countdown Timer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const TimerScreen(),
    );
  }
}

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MTOI Exception Console'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ScaffoldHeaderTimer(),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            M3TimerBanner(status: 'Complete', fps: 60.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('MTOI Exception Handling active - countdown timer bound to header bar.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
