// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/velocity_tracking_scroller_widget.dart';

void main() {
  runApp(const VelocityTrackingApp());
}

class VelocityTrackingApp extends StatelessWidget {
  const VelocityTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smooth List Scroller Velocity Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const VelocityTrackingScrollerWidget(),
    );
  }
}
