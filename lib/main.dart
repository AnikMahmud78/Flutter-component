import 'package:flutter/material.dart';
import 'models/gesture_event_model.dart';
import 'widgets/gesture_tracker_card.dart';

void main() {
  runApp(const GestureTrackerApp());
}

class GestureTrackerApp extends StatelessWidget {
  const GestureTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Telemetry App',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const GestureTrackerScreen(),
    );
  }
}

class GestureTrackerScreen extends StatefulWidget {
  const GestureTrackerScreen({Key? key}) : super(key: key);

  @override
  State<GestureTrackerScreen> createState() => _GestureTrackerScreenState();
}

class _GestureTrackerScreenState extends State<GestureTrackerScreen> {
  GestureEventModel _model = const GestureEventModel(lastGesture: 'None', detectionAccuracy: 0.96);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Capture Console')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureTrackerCard(
              model: _model,
              onGestureCaptured: (gestureName) {
                setState(() {
                  _model = GestureEventModel(lastGesture: gestureName, detectionAccuracy: 0.96);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
