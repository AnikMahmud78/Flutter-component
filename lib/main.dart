import 'package:flutter/material.dart';
import 'models/realtime_status_model.dart';
import 'widgets/realtime_status_card.dart';

void main() {
  runApp(const RealTimeStatusApp());
}

class RealTimeStatusApp extends StatelessWidget {
  const RealTimeStatusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Telemetry Dispatch',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: const RealTimeStatusScreen(),
    );
  }
}

class RealTimeStatusScreen extends StatefulWidget {
  const RealTimeStatusScreen({Key? key}) : super(key: key);

  @override
  State<RealTimeStatusScreen> createState() => _RealTimeStatusScreenState();
}

class _RealTimeStatusScreenState extends State<RealTimeStatusScreen> {
  RealTimeStatusModel _currentModel = RealTimeStatusModel(
    dispatchId: 'DSP-9510-01',
    latencyMs: 142,
    timestamp: DateTime.now(),
  );

  void _runDispatchTest() {
    setState(() {
      _currentModel = RealTimeStatusModel(
        dispatchId: 'DSP-9510-\${DateTime.now().millisecondsSinceEpoch}',
        latencyMs: 98,
        timestamp: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dispatch SLA Tester')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RealTimeStatusCard(
              model: _currentModel,
              onTriggerDispatch: _runDispatchTest,
            ),
          ],
        ),
      ),
    );
  }
}
