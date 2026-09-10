import 'package:flutter/material.dart';

class BinaryChecklistStepper3636BPTR0437A03 extends StatefulWidget {
  const BinaryChecklistStepper3636BPTR0437A03({super.key});

  @override
  State<BinaryChecklistStepper3636BPTR0437A03> createState() => _BinaryChecklistStepper3636BPTR0437A03State();
}

class _BinaryChecklistStepper3636BPTR0437A03State extends State<BinaryChecklistStepper3636BPTR0437A03> {
  static const _steps = ['Source verified', 'Mapping approved', 'Validation passed', 'Destination ready'];
  final _answers = List<bool?>.filled(_steps.length, null);
  int _currentStep = 0;

  bool get _complete => _answers.every((answer) => answer == true);

  void _continue() {
    if (_answers[_currentStep] != true) return;
    setState(() => _currentStep = (_currentStep + 1).clamp(0, _steps.length - 1));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Binary Checklist Stepper')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.rule_rounded), title: Text('3636BPTR-0437-A03'), subtitle: Text('Strict binary sequence with final CTA gating.')),
          const SizedBox(height: 16),
          LinearProgressIndicator(value: (_currentStep + 1) / _steps.length),
          const SizedBox(height: 8),
          Text('Step ${_currentStep + 1} of ${_steps.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(_steps.length, (index) => Card.outlined(child: RadioListTile<bool>(
                value: true,
                groupValue: _answers[index],
                title: Text(_steps[index]),
                subtitle: Text(_answers[index] == true ? 'YES' : 'ACTIVE RISK'),
                onChanged: index <= _currentStep ? (value) => setState(() => _answers[index] = value) : null,
              ))),
          const SizedBox(height: 12),
          SizedBox(height: 48, child: FilledButton.icon(onPressed: _answers[_currentStep] == true ? _continue : null, icon: const Icon(Icons.navigate_next_rounded), label: const Text('CONTINUE'))),
          const SizedBox(height: 8),
          SizedBox(height: 48, child: FilledButton.icon(onPressed: _complete ? () {} : null, icon: const Icon(Icons.check_circle_rounded), label: const Text('COMPLETE'))),
          const SizedBox(height: 16),
          const Card.outlined(child: ListTile(title: Text('Layout Consistency: Good'), subtitle: Text('Source-to-target mapping uses an atomic binary checklist.'))),
        ],
      );
}
