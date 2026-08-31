// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/visual_layout_verification_widget.dart';

void main() {
  runApp(const VisualLayoutApp());
}

class VisualLayoutApp extends StatelessWidget {
  const VisualLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic Visual Layout Verification',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const VisualLayoutVerificationWidget(),
    );
  }
}
