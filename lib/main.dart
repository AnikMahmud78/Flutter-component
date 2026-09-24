import 'package:flutter/material.dart';
import 'widgets/poka_yoke_guard_card.dart';
import 'models/poka_yoke_telemetry.dart';

void main() {
  runApp(const HabotPokaYokeApp());
}

class HabotPokaYokeApp extends StatelessWidget {
  const HabotPokaYokeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Poka-Yoke Fraud Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF005AC1)),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('HABOT Fraud Prevention Console')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: PokaYokeGuardCard(
            onExecutionLogged: (PokaYokeTelemetry telemetry) {
              debugPrint('BigQuery Telemetry Stream: ${telemetry.toJson()}');
            },
          ),
        ),
      ),
    );
  }
}
