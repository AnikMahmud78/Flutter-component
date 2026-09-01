// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/master_shell_doc_screen.dart';

void main() {
  runApp(const MasterShellDocApp());
}

class MasterShellDocApp extends StatelessWidget {
  const MasterShellDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Master Shell Architecture Spec',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const MasterShellDocScreen(),
    );
  }
}
