import 'package:flutter/material.dart';

class ProgressiveDisclosureBottomSheet2910BPTR0392A13 extends StatefulWidget {
  const ProgressiveDisclosureBottomSheet2910BPTR0392A13({super.key});

  @override
  State<ProgressiveDisclosureBottomSheet2910BPTR0392A13> createState() => _ProgressiveDisclosureBottomSheet2910BPTR0392A13State();
}

class _ProgressiveDisclosureBottomSheet2910BPTR0392A13State extends State<ProgressiveDisclosureBottomSheet2910BPTR0392A13> {
  String? _selection;

  Future<void> _openSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('Choose Issue Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              RadioListTile(value: 'SLA_BREACH', groupValue: _selection, title: const Text('SLA breach'), onChanged: (value) => setSheetState(() => _selection = value)),
              RadioListTile(value: 'BUFFER_OVERFLOW', groupValue: _selection, title: const Text('Buffer overflow'), onChanged: (value) => setSheetState(() => _selection = value)),
              SizedBox(width: double.infinity, height: 48, child: FilledButton(onPressed: _selection == null ? null : () => Navigator.pop(sheetContext, _selection), child: const Text('APPLY'))),
            ]),
          ),
        ),
      ),
    );
    if (mounted && result != null) setState(() => _selection = result);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Progressive Disclosure Bottom Sheets')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.layers_rounded), title: Text('2910BPTR-0392-A13'), subtitle: Text('Contextual choices stay inside a dismissible Material bottom sheet.')),
          const SizedBox(height: 16),
          SizedBox(height: 48, child: FilledButton.icon(onPressed: _openSheet, icon: const Icon(Icons.open_in_new_rounded), label: const Text('OPEN CATEGORY SHEET'))),
          const SizedBox(height: 16),
          Card.outlined(child: ListTile(title: Text(_selection == null ? 'No category selected' : 'Selected: $_selection'), subtitle: const Text('UI input response target: under 100ms'))),
        ],
      );
}
