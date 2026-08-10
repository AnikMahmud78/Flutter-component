import 'package:flutter/material.dart';
import 'widgets/touch_spacing_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ACTS 48x48dp Touch Systems',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const TouchSpacingDemo(),
    );
  }
}
