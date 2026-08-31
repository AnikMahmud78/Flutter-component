import 'package:flutter/material.dart';
import 'widgets/contrast_action_header_widget.dart';

void main() {
  runApp(const ContrastHeaderApp());
}

class ContrastHeaderApp extends StatelessWidget {
  const ContrastHeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contrast Action Header',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const ContrastActionHeaderWidget(),
    );
  }
}
