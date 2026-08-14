import 'package:flutter/material.dart';
import 'widgets/system_verb_cta_auditor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'System-Verb CTA Character Limit Auditor',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const SystemVerbCtaAuditorWidget(),
    );
  }
}
