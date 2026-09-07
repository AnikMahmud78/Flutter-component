import 'package:flutter/material.dart';
import 'widgets/atomic_button_widget.dart';

void main() {
  runApp(const AtomicButtonApp());
}

class AtomicButtonApp extends StatelessWidget {
  const AtomicButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atomic Byt Micro-Interactions App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AtomicButtonInspectorWidget(),
    );
  }
}
