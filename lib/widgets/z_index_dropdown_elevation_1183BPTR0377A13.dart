import 'package:flutter/material.dart';

class ZIndexDropdownElevation1183BPTR0377A13 extends StatefulWidget {
  const ZIndexDropdownElevation1183BPTR0377A13({super.key});

  @override
  State<ZIndexDropdownElevation1183BPTR0377A13> createState() =>
      _ZIndexDropdownElevation1183BPTR0377A13State();
}

class _ZIndexDropdownElevation1183BPTR0377A13State
    extends State<ZIndexDropdownElevation1183BPTR0377A13> {
  static const _dropdownElevation = 20.0;
  String _selection = 'Choose elevation tier';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dropdown Elevation Tokens')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.arrow_drop_down_circle_rounded),
            title: Text('1183BPTR-0377-A13'),
            subtitle: Text(
              'Floating select menus use the locked dropdown tier.',
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Elevation Tier',
              border: OutlineInputBorder(),
            ),
            value: _selection == 'Choose elevation tier' ? null : _selection,
            items: const [
              DropdownMenuItem(
                value: 'Base content',
                child: Text('Base content (z-0)'),
              ),
              DropdownMenuItem(
                value: 'Dropdown overlay',
                child: Text('Dropdown overlay (z-20)'),
              ),
              DropdownMenuItem(
                value: 'Modal sheet',
                child: Text('Modal sheet (z-30)'),
              ),
            ],
            onChanged: (value) =>
                setState(() => _selection = value ?? _selection),
            menuMaxHeight: 240,
          ),
          const SizedBox(height: 16),
          Card.outlined(
            child: ListTile(
              title: Text('Selected: $_selection'),
              subtitle: const Text('Applied token: dropdown overlay / z-20'),
              trailing: const Icon(Icons.layers_rounded),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Locked elevation: $_dropdownElevation',
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }
}
