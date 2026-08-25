import 'package:flutter/material.dart';
import 'widgets/human_processing_template_widget.dart';

void main() {
  runApp(const HumanProcessingApp());
}

class HumanProcessingApp extends StatelessWidget {
  const HumanProcessingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Human Processing Step Template',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HumanProcessingTemplateWidget(),
    );
  }
}
