import 'package:flutter/material.dart';
import 'widgets/vocabulary_choice_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Vocabulary Choice Menu',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const VocabularyChoiceSheetScreen(),
    );
  }
}
