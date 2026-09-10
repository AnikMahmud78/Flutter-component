import 'package:flutter/material.dart';

class ZIndexLayeringScale831BPTR0377A08 extends StatelessWidget {
  const ZIndexLayeringScale831BPTR0377A08({super.key});

  static const _levels = <String, int>{
    'Base content': 0,
    'Sticky header': 10,
    'Dropdown overlay': 20,
    'Modal sheet': 30,
    'Shakti alert': 40,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Z-Index Layering Scale')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.layers_rounded),
            title: Text('831BPTR-0377-A08'),
            subtitle: Text('Fixed elevation tiers prevent arbitrary overlay values.'),
          ),
          const SizedBox(height: 12),
          ..._levels.entries.map((entry) => Card.outlined(
                child: ListTile(
                  title: Text(entry.key),
                  trailing: Chip(label: Text('z-${entry.value}')),
                ),
              )),
          const Card.outlined(child: ListTile(
            title: Text('Validation Status: Good'),
            subtitle: Text('Configuration Type: LOCKED_GLOBAL_ELEVATION_SCALE'),
          )),
        ],
      ),
    );
  }
}
