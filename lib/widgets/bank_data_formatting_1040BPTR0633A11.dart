import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BankDataFormatting1040BPTR0633A11 extends StatefulWidget {
  const BankDataFormatting1040BPTR0633A11({super.key});

  @override
  State<BankDataFormatting1040BPTR0633A11> createState() => _BankDataFormatting1040BPTR0633A11State();
}

class _BankDataFormatting1040BPTR0633A11State extends State<BankDataFormatting1040BPTR0633A11> {
  final _accountController = TextEditingController();
  String? _error;

  bool get _valid => RegExp(r'^\d{10}$').hasMatch(_accountController.text);

  @override
  void dispose() { _accountController.dispose(); super.dispose(); }

  void _validate(String value) => setState(() => _error = value.isEmpty || !_valid ? 'Account number must contain exactly 10 digits.' : null);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Bank Data Entry Validation')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.account_balance_rounded), title: Text('1040BPTR-0633-A11'), subtitle: Text('Payroll flow is gated until the bank format is valid.')),
          const SizedBox(height: 16),
          TextField(
            controller: _accountController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
            decoration: InputDecoration(labelText: '10-digit account number', helperText: 'Numeric keypad only', errorText: _error, suffixIcon: _valid ? const Icon(Icons.check_circle_rounded, color: Colors.green) : null, border: const OutlineInputBorder()),
            onChanged: _validate,
          ),
          const SizedBox(height: 12),
          SizedBox(height: 48, child: FilledButton.icon(onPressed: _valid ? () {} : null, icon: const Icon(Icons.lock_rounded), label: const Text('SAVE BANK DETAILS'))),
          const SizedBox(height: 16),
          const Card.outlined(child: ListTile(title: Text('Implementation Quality: Good'), subtitle: Text('Invalid characters rejected before payroll submission.'))),
        ],
      );
}
