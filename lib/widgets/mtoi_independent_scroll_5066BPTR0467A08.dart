import 'package:flutter/material.dart';

class MtoiIndependentScroll5066BPTR0467A08 extends StatelessWidget {
  const MtoiIndependentScroll5066BPTR0467A08({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('MTOI Independent Panel Scrolling')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            '5066BPTR-0467-A08',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final source = _panel(
                  'Read-only source',
                  const Text(
                    'TXN-88421\nPayload snippet\nStatus: UNLINKED',
                    style: TextStyle(fontFamily: 'monospace'),
                  ),
                );
                final destination = _panel(
                  'Destination form',
                  Column(
                    children: const [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Validated value',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('Vertical scroll is isolated to this panel.'),
                    ],
                  ),
                );
                if (constraints.maxWidth >= 600)
                  return Row(
                    children: [
                      Expanded(child: source),
                      const SizedBox(width: 16),
                      Expanded(child: destination),
                    ],
                  );
                return Column(
                  children: [
                    Expanded(child: source),
                    const SizedBox(height: 16),
                    Expanded(child: destination),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ),
  );

  Widget _panel(String title, Widget child) => Card.outlined(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 8),
              child: child,
            ),
          ),
        ],
      ),
    ),
  );
}
