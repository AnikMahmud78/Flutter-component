import 'package:flutter/material.dart';
import 'widgets/universal_ui_audit_screen.dart';

void main() {
  runApp(const UniversalUiAuditApp());
}

class UniversalUiAuditApp extends StatelessWidget {
  const UniversalUiAuditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Universal UI Integration Audit',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const UniversalUiAuditScreen(),
    );
  }
}
