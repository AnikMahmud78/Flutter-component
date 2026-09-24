import 'package:flutter/material.dart';
import 'services/strict_compliance_checker.dart';

void main() => runApp(const BooleanComplianceApp());

class BooleanComplianceApp extends StatelessWidget {
  const BooleanComplianceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final checker = StrictComplianceChecker();
    final bool isCompliant = checker.checkSoxCompliance({'isApproved': true, 'hasAuditTrail': true});

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Strict Boolean Compliance Evaluator')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Compliance Status: \${isCompliant ? "TRUE" : "FALSE"}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
