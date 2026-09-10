import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PokaYokeNumeric556BPTR0725A04 extends StatefulWidget {
  const PokaYokeNumeric556BPTR0725A04({super.key});

  @override
  State<PokaYokeNumeric556BPTR0725A04> createState() => _PokaYokeNumeric556BPTR0725A04State();
}

class _PokaYokeNumeric556BPTR0725A04State extends State<PokaYokeNumeric556BPTR0725A04> {
  final _ageController = TextEditingController();
  final _earningsController = TextEditingController();

  bool get _validAge {
    final age = int.tryParse(_ageController.text);
    return age != null && age >= 0 && age <= 120;
  }

  bool get _validEarnings {
    final earnings = int.tryParse(_earningsController.text);
    return earnings != null && earnings >= 0;
  }

  @override
  void dispose() { _ageController.dispose(); _earningsController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Poka-Yoke Numeric Forms')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.rule_rounded), title: Text('556BPTR-0725-A04'), subtitle: Text('Age and earnings fields reject alphabetic input at source.')),
          const SizedBox(height: 16),
          TextField(controller: _ageController, keyboardType: TextInputType.number, inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)], decoration: const InputDecoration(labelText: 'Child age (0-120)', helperText: 'Numeric keypad only', border: OutlineInputBorder()), onChanged: (_) => setState(() {})),
          const SizedBox(height: 12),
          TextField(controller: _earningsController, keyboardType: TextInputType.number, inputFormatters: [FilteringTextInputFormatter.digitsOnly], decoration: const InputDecoration(labelText: 'Annual earnings', helperText: 'Whole numeric value', border: OutlineInputBorder()), onChanged: (_) => setState(() {})),
          const SizedBox(height: 16),
          SizedBox(height: 48, child: FilledButton.icon(onPressed: _validAge && _validEarnings ? () {} : null, icon: const Icon(Icons.check_rounded), label: const Text('SAVE VALIDATED DATA'))),
          const SizedBox(height: 16),
          Card.outlined(child: ListTile(title: Text(_validAge && _validEarnings ? 'Validation: PASS' : 'Validation: ACTIVE RISK'), subtitle: const Text('Backend integer constraints mirrored in the mobile form.'))),
        ],
      );
}
