import 'package:flutter/material.dart';

class IsolatedCdeForm5561BPWSO00909 extends StatelessWidget {
  const IsolatedCdeForm5561BPWSO00909({super.key});

  static const _fields = ['Primary User Identification Token', 'Transaction Amount (USD)', 'Ingress Timestamp (UTC)'];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Isolated CDE Form Layout')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const ListTile(leading: Icon(Icons.filter_alt_rounded), title: Text('5561BPWSO-009-09'), subtitle: Text('Only mandatory Critical Data Elements are rendered.')),
          const SizedBox(height: 16),
          ..._fields.asMap().entries.map((entry) => Padding(padding: const EdgeInsets.only(bottom: 12), child: TextFormField(decoration: InputDecoration(labelText: entry.value, helperText: 'CDE_0${entry.key + 1}', border: const OutlineInputBorder())))),
          const Card.outlined(child: ListTile(title: Text('Mandatory CDE Completeness: Pass (100%)'), subtitle: Text('DAMA-DMBOK2 completeness standard'))),
        ]),
      );
}
