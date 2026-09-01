// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/jank_free_scroller_widget.dart';

void main() {
  runApp(const JankFreeScrollerApp());
}

class JankFreeScrollerApp extends StatelessWidget {
  const JankFreeScrollerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smooth List Scroller Jank Free Optimization',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const JankFreeScrollerWidget(),
    );
  }
}
