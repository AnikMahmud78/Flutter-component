// Location: lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/master_shell_scaffolding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global Release Dashboard Master Shell',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const MasterShellScaffolding(),
    );
  }
}
