import 'package:flutter/material.dart';
import 'widgets/schema_header_card_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Database Catalog Schema Template',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const SchemaHeaderCardWidget(),
    );
  }
}
