import 'package:flutter/material.dart';
import 'widgets/liveness_handshake_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Infrastructure Liveness Handshake',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const LivenessHandshakeScreen(),
    );
  }
}
