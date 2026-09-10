import 'package:flutter/material.dart';

class NarrativeUiWaste3911BPTR0349A04 extends StatefulWidget {
  const NarrativeUiWaste3911BPTR0349A04({super.key});

  @override
  State<NarrativeUiWaste3911BPTR0349A04> createState() => _NarrativeUiWaste3911BPTR0349A04State();
}

class _NarrativeUiWaste3911BPTR0349A04State extends State<NarrativeUiWaste3911BPTR0349A04> {
  String? _category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Structured Exception Review')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.cleaning_services_rounded),
            title: Text('3911BPTR-0349-A04'),
            subtitle: Text('Narrative UI waste removed; choose a structured category.'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Exception Category', border: OutlineInputBorder()),
            value: _category,
            items: const [
              DropdownMenuItem(value: 'SLA_BREACH', child: Text('SLA breach')),
              DropdownMenuItem(value: 'BUFFER_OVERFLOW', child: Text('Buffer overflow')),
              DropdownMenuItem(value: 'ROUTE_TRANSITION', child: Text('Route transition')),
            ],
            onChanged: (value) => setState(() => _category = value),
          ),
          const SizedBox(height: 16),
          SizedBox(height: 48, child: FilledButton.icon(
            onPressed: _category == null ? null : () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Structured exception submitted.'))),
            icon: const Icon(Icons.check_rounded),
            label: const Text('SUBMIT STRUCTURED REVIEW'),
          )),
          const SizedBox(height: 16),
          const Card.outlined(child: ListTile(
            title: Text('Execution Status: PASS'),
            subtitle: Text('Unstructured narrative fields: 0'),
          )),
        ],
      ),
    );
  }
}
