import 'package:flutter/material.dart';
import 'widgets/floating_video_training_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '60s Floating Video Micro-Training',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const FloatingVideoTrainingWidget(),
    );
  }
}
