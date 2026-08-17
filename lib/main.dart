import 'package:flutter/material.dart';
import 'widgets/dynamic_layout_renderer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programmatic Layout Mapping Engine',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const DynamicLayoutRendererScreen(),
    );
  }
}
