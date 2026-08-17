import 'package:flutter/material.dart';
import 'widgets/atomic_cde_wizard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deconstruct CDEs into Bytes Wizard',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AtomicCdeWizardScreen(),
    );
  }
}
