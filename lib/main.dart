// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/screen_performance_tag_widget.dart';

void main() {
  runApp(const ScreenPerformanceApp());
}

class ScreenPerformanceApp extends StatelessWidget {
  const ScreenPerformanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Performance Tag Extractor',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const ScreenPerformanceTagWidget(),
    );
  }
}
