// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/inertial_deceleration_scroller_widget.dart';

void main() {
  runApp(const InertialDecelerationApp());
}

class InertialDecelerationApp extends StatelessWidget {
  const InertialDecelerationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smooth List Scroller Inertial Deceleration',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const InertialDecelerationScrollerWidget(),
    );
  }
}
