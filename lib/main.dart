// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/bulk_action_guardrail_modal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bulk Action Deletion Guardrail Engine',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const BulkActionGuardrailScreen(),
    );
  }
}
