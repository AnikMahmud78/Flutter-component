import 'package:flutter/material.dart';
import 'widgets/m3_assistive_text_field.dart';

void main() => runApp(const TextFieldsApp());

class TextFieldsApp extends StatelessWidget {
  const TextFieldsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: Scaffold(
        appBar: AppBar(title: const Text('M3 Assistive Text Fields')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              M3AssistiveTextField(
                labelText: 'API Gateway Endpoint',
                helperText: 'Enter full qualified URL including https:// scheme',
                validator: (val) => (val?.isEmpty ?? true) ? 'Endpoint is required' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
