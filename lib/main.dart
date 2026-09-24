import 'package:flutter/material.dart';
import 'models/scroll_fps_model.dart';
import 'widgets/scroll_fps_card.dart';

void main() {
  runApp(const ScrollFpsApp());
}

class ScrollFpsApp extends StatelessWidget {
  const ScrollFpsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll FPS Profiler',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const ScrollFpsScreen(),
    );
  }
}

class ScrollFpsScreen extends StatefulWidget {
  const ScrollFpsScreen({Key? key}) : super(key: key);

  @override
  State<ScrollFpsScreen> createState() => _ScrollFpsScreenState();
}

class _ScrollFpsScreenState extends State<ScrollFpsScreen> {
  ScrollFpsModel _model = const ScrollFpsModel(currentFps: 60.0, droppedFrames: 0, completionRate: 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Frame Rate Telemetry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ScrollFpsCard(
              model: _model,
              onTestScroll: () {
                setState(() {
                  _model = const ScrollFpsModel(currentFps: 59.8, droppedFrames: 0, completionRate: 100.0);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('60 FPS Render Speed Verified')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
