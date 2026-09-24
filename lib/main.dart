import 'package:flutter/material.dart';
import 'services/token_audit_engine.dart';

void main() => runApp(const TokenAuditApp());

class TokenAuditApp extends StatelessWidget {
  const TokenAuditApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auditEngine = TokenAuditEngine();
    final sampleCode = [
      "color: md.sys.color.primary",
      "padding: Spacing.medium",
      "color: md.sys.color.surface",
    ];
    final score = auditEngine.auditSourceCode(sampleCode);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('NPM Token Audit Engine')),
        body: Center(
          child: Text(
            'Token Compliance Rate: \${(score * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
