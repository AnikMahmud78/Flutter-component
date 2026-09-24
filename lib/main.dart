import 'package:flutter/material.dart';
import 'services/payroll_validator.dart';

void main() => runApp(const PayrollAutoApp());

class PayrollAutoApp extends StatelessWidget {
  const PayrollAutoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final validator = PayrollValidator();
    final entry = validator.processEntry('EMP-4401', 'GB82WEST12345698765432', 4500.00);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Zero Manual Payroll Automation')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Employee: \${entry.employeeId}'),
              Text('IBAN: \${entry.iban}'),
              Text('Amount: \\$\${entry.amount}'),
              const SizedBox(height: 16),
              Card(
                color: entry.isAutoProcessed ? Colors.green.shade50 : Colors.red.shade50,
                child: ListTile(
                  leading: Icon(
                    entry.isAutoProcessed ? Icons.autorenew : Icons.warning,
                    color: entry.isAutoProcessed ? Colors.green : Colors.red,
                  ),
                  title: Text('Automated Validation Status'),
                  subtitle: Text(
                    entry.isAutoProcessed
                        ? '100% Automated - 0% Manual Intervention Required'
                        : 'Validation Failure - Intervention Needed',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
