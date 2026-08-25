import 'package:flutter/material.dart';
import 'widgets/agentic_handoff_animation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agentic Task Handoff Micro-Animations',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AgenticHandoffAnimationWidget(),
    );
  }
}
