import 'package:flutter/material.dart';

class M3ComplianceForm extends StatefulWidget {
  final VoidCallback onValidationPass;

  const M3ComplianceForm({Key? key, required this.onValidationPass}) : super(key: key);

  @override
  State<M3ComplianceForm> createState() => _M3ComplianceFormState();
}

class _M3ComplianceFormState extends State<M3ComplianceForm> {
  final TextEditingController _inputController = TextEditingController();
  String? _errorText;

  // English Code (EC): Validate-Compliance-Input
  void validateComplianceInput(String value) {
    if (value.trim().isEmpty || value.length < 5) {
      setState(() {
        _errorText = 'NON-COMPLIANCE DETECTED: Code must be at least 5 alphanumeric characters.';
      });
    } else {
      setState(() {
        _errorText = null;
      });
    }
  }

  // English Code (EC): Show-Compliance-Alert-Dialog
  void showComplianceAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          icon: Icon(Icons.warning_amber_rounded, color: Theme.of(ctx).colorScheme.error, size: 36),
          title: Text('Compliance Violation Alert', style: TextStyle(color: Theme.of(ctx).colorScheme.error)),
          content: const Text(
            'The entered system configuration violates strict Material 3 and WCAG 2.2 AA accessibility contrast policies. Please review and revise input values.',
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(minimumSize: const Size(88, 48)),
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('DISMISS'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(88, 48),
                backgroundColor: Theme.of(ctx).colorScheme.error,
                foregroundColor: Theme.of(ctx).colorScheme.onError,
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                validateComplianceInput(_inputController.text);
              },
              child: const Text('CORRECT NOW'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _inputController,
          onChanged: validateComplianceInput,
          decoration: InputDecoration(
            labelText: 'Configuration Token',
            errorText: _errorText,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.security),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton.tonal(
            onPressed: () => showComplianceAlertDialog(context),
            child: const Text('TRIGGER NON-COMPLIANCE WARNING DIALOG'),
          ),
        ),
      ],
    );
  }
}
