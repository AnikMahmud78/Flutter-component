import 'package:flutter/material.dart';
import 'widgets/required_fields_form.dart';

void main() {
  runApp(const FormEnforcementApp());
}

class FormEnforcementApp extends StatelessWidget {
  const FormEnforcementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Required Field Enforcement',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: Scaffold(
        appBar: AppBar(title: const Text('Strict Form Completion Gate')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: RequiredFieldsForm(
            onSubmitResult: (pass) {},
          ),
        ),
      ),
    );
  }
}
