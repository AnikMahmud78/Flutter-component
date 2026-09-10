import 'package:flutter/material.dart';

class MtoiDestinationPanel4780BPTR0467A07 extends StatefulWidget {
  const MtoiDestinationPanel4780BPTR0467A07({super.key});

  @override
  State<MtoiDestinationPanel4780BPTR0467A07> createState() =>
      _MtoiDestinationPanel4780BPTR0467A07State();
}

class _MtoiDestinationPanel4780BPTR0467A07State
    extends State<MtoiDestinationPanel4780BPTR0467A07> {
  final _valueController = TextEditingController();

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('MTOI Destination Template')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const ListTile(
          leading: Icon(Icons.input_rounded),
          title: Text('4780BPTR-0467-A07'),
          subtitle: Text(
            'Local destination data form for BigQuery validation.',
          ),
        ),
        const SizedBox(height: 16),
        Card.outlined(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Source: TXN-88421',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
                const Divider(),
                TextField(
                  controller: _valueController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Validated destination value',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _valueController.text.isEmpty ? null : () {},
                    icon: const Icon(Icons.cloud_upload_rounded),
                    label: const Text('VALIDATE DESTINATION'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Card.outlined(
          child: ListTile(
            title: Text('Layout Consistency: Good'),
            subtitle: Text(
              'Right panel contains one type-constrained destination field.',
            ),
          ),
        ),
      ],
    ),
  );
}
