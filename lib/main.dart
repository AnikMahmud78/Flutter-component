import 'package:flutter/material.dart';
import 'widgets/lead_conversion_audit_widget.dart';

void main() {
  runApp(const LeadConversionAuditApp());
}

class LeadConversionAuditApp extends StatelessWidget {
  const LeadConversionAuditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M3 Layout Compliance Audit App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LeadConversionAuditWidget(),
    );
  }
}
