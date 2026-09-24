import 'package:flutter/material.dart';
import 'widgets/m3_compliance_dialog.dart';

void main() {
  runApp(const ComplianceDialogApp());
}

class ComplianceDialogApp extends StatelessWidget {
  const ComplianceDialogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('M3 Compliance Console')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: M3ComplianceForm(onValidationPass: () {}),
        ),
      ),
    );
  }
}
