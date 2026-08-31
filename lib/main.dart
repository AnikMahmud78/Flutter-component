// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/schema_collator_widget.dart';

void main() {
  runApp(const SchemaCollatorApp());
}

class SchemaCollatorApp extends StatelessWidget {
  const SchemaCollatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dependency Chain Schema Collator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const SchemaCollatorWidget(),
    );
  }
}
