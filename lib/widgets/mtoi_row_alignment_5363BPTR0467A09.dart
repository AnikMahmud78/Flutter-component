import 'package:flutter/material.dart';

class MtoiRowAlignment5363BPTR0467A09 extends StatelessWidget {
  const MtoiRowAlignment5363BPTR0467A09({super.key});

  static const _rows = [
    ('Amount', '1,245.50'),
    ('Status', 'UNLINKED'),
    ('Reference', 'TXN-88421'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('MTOI Row Alignment Links')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const ListTile(
          leading: Icon(Icons.compare_arrows_rounded),
          title: Text('5363BPTR-0467-A09'),
          subtitle: Text(
            'Matching properties are connected by alignment lines.',
          ),
        ),
        const SizedBox(height: 12),
        ..._rows.map(
          (row) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: Card.outlined(
                    child: ListTile(
                      title: Text(row.$1),
                      subtitle: Text('Source: ${row.$2}'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.link_rounded, color: Colors.indigo),
                const SizedBox(width: 8),
                Expanded(
                  child: Card.outlined(
                    child: ListTile(
                      title: Text(row.$1),
                      subtitle: Text('Destination: ${row.$2}'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Card.outlined(
          child: ListTile(
            title: Text('Layout Validation: Good'),
            subtitle: Text(
              'Every source property has one aligned destination property.',
            ),
          ),
        ),
      ],
    ),
  );
}
