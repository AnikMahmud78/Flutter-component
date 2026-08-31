import 'package:flutter/material.dart';
import 'widgets/contextual_navigation_header_widget.dart';

void main() {
  runApp(const ContextualHeaderApp());
}

class ContextualHeaderApp extends StatelessWidget {
  const ContextualHeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contextual Navigation Header',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const ContextualNavigationHeaderWidget(),
    );
  }
}
