import 'package:flutter/material.dart';
import 'widgets/master_document_stepper_widget.dart';

void main() {
  runApp(const MasterDocumentSealApp());
}

class MasterDocumentSealApp extends StatelessWidget {
  const MasterDocumentSealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seal Master EC Document (ED 4)',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const MasterDocumentStepperWidget(),
    );
  }
}
