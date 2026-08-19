// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/global_touch_target_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global Touch-Target Baseline Engine',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const GlobalTouchTargetScreen(),
    );
  }
}
