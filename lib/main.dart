import 'package:flutter/material.dart';
import 'widgets/typography_engine_widget.dart';

void main() {
  runApp(const TypographyEngineApp());
}

class TypographyEngineApp extends StatelessWidget {
  const TypographyEngineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Typography Engine App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const TypographyEngineInspectorWidget(),
    );
  }
}
