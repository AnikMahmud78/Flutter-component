import 'package:flutter/material.dart';
import 'widgets/cde_audit_engine_5924CPNCA008.dart';

void main() {
  runApp(const CdeAuditEngine5924CPNCA008App());
}

class CdeAuditEngine5924CPNCA008App extends StatelessWidget {
  const CdeAuditEngine5924CPNCA008App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CDE Audit Engine App',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const CdeAuditEngine5924CPNCA008(),
  );
}
