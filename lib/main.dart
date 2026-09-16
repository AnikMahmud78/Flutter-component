import 'package:flutter/material.dart';
import 'models/dynamic_form_model.dart';
import 'widgets/dynamic_form_assembler.dart';
import 'widgets/telemetry_status_banner.dart';

void main() {
  runApp(const DynamicFormApp());
}

class DynamicFormApp extends StatelessWidget {
  const DynamicFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const FormRunnerScreen(),
    );
  }
}

class FormRunnerScreen extends StatelessWidget {
  const FormRunnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FieldDescriptor> schema = const [
      FieldDescriptor(key: 'lib_name', label: 'Library Name', type: FieldType.text, isRequired: true, placeholder: 'Universal Component Library'),
      FieldDescriptor(key: 'lib_ver', label: 'Library Version', type: FieldType.text, isRequired: true, placeholder: 'v2.4.0'),
      FieldDescriptor(key: 'comp_count', label: 'Component Count', type: FieldType.number, isRequired: true, placeholder: '48'),
      FieldDescriptor(key: 'status', label: 'Installation Status', type: FieldType.dropdown, isRequired: true, options: ['Installed', 'Pending', 'Failed']),
      FieldDescriptor(key: 'telemetry', label: 'Enable Observability Telemetry', type: FieldType.toggle),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Form Engine (FIEVR-028)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TelemetryStatusBanner(status: 'Pass', errorRate: 0.5),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DynamicFormAssembler(
                  schema: schema,
                  onSubmit: (data) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form Submitted Successfully: ${data.keys.length} fields')),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
