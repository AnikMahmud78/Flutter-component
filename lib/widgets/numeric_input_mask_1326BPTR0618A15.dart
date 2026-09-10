import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericInputMask1326BPTR0618A15 extends StatefulWidget {
  const NumericInputMask1326BPTR0618A15({super.key});

  @override
  State<NumericInputMask1326BPTR0618A15> createState() => _NumericInputMask1326BPTR0618A15State();
}

class _NumericInputMask1326BPTR0618A15State extends State<NumericInputMask1326BPTR0618A15> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  void _validate(String value) {
    setState(() => _error = value.isEmpty || int.tryParse(value) == null ? 'Enter numeric digits only.' : null);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Numeric Input Masking')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.filter_9_plus_rounded), title: Text('1326BPTR-0618-A15'), subtitle: Text('Alphabetic keystrokes are rejected at the input boundary.')),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: 'Financial numeric value', helperText: 'Numbers only', errorText: _error, border: const OutlineInputBorder()),
            onChanged: _validate,
          ),
          const SizedBox(height: 16),
          SizedBox(height: 48, child: FilledButton.icon(onPressed: _error == null && _controller.text.isNotEmpty ? () {} : null, icon: const Icon(Icons.save_rounded), label: const Text('SAVE VALUE'))),
          const SizedBox(height: 16),
          const Card.outlined(child: ListTile(title: Text('Layout Consistency: Good'), subtitle: Text('Native numeric keyboard and inline validation enabled.'))),
        ],
      );
}
