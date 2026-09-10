import 'package:flutter/material.dart';

class MtoiSplitScreen4472BPTR0467A06 extends StatefulWidget {
  const MtoiSplitScreen4472BPTR0467A06({super.key});

  @override
  State<MtoiSplitScreen4472BPTR0467A06> createState() => _MtoiSplitScreen4472BPTR0467A06State();
}

class _MtoiSplitScreen4472BPTR0467A06State extends State<MtoiSplitScreen4472BPTR0467A06> {
  final _repairController = TextEditingController();

  @override
  void dispose() {
    _repairController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MTOI Exception Review')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const Text('4472BPTR-0467-A06', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            final horizontal = constraints.maxWidth >= 600;
            final source = _sourcePanel();
            final input = _inputPanel();
            return horizontal ? Row(children: [Expanded(child: source), const SizedBox(width: 16), Expanded(child: input)]) : Column(children: [Expanded(child: source), const SizedBox(height: 16), Expanded(child: input)]);
          })),
        ]),
      ),
    );
  }

  Widget _sourcePanel() => Card.outlined(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
    Text('Incoming Payload', style: TextStyle(fontWeight: FontWeight.bold)),
    Divider(),
    Expanded(child: SingleChildScrollView(child: Text('TXN-88421\nAmount: 1,245.50\nStatus: UNLINKED\nSource: external_gateway', style: TextStyle(fontFamily: 'monospace')))),
  ]));

  Widget _inputPanel() => Card.outlined(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Validated Repair Value', style: TextStyle(fontWeight: FontWeight.bold)),
    const Divider(),
    TextField(controller: _repairController, autofocus: true, onChanged: (_) => setState(() {}), decoration: const InputDecoration(labelText: 'Repair value', border: OutlineInputBorder())),
    const SizedBox(height: 16),
    SizedBox(width: double.infinity, height: 48, child: FilledButton(onPressed: _repairController.text.isEmpty ? null : () {}, child: const Text('SUBMIT REPAIR'))),
  ]));
}
