// lib/widgets/pii_normalizer_card.dart
import 'package:flutter/material.dart';

class PiiNormalizerCard extends StatefulWidget {
  const PiiNormalizerCard({super.key});

  @override
  State<PiiNormalizerCard> createState() => _PiiNormalizerCardState();
}

class _PiiNormalizerCardState extends State<PiiNormalizerCard> {
  final TextEditingController _inputCtrl = TextEditingController(text: '   User.Anik@Habot.IO  ');
  String _normalized = 'user.anik@habot.io';

  void _normalizeString() {
    setState(() {
      _normalized = _inputCtrl.text.trim().toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PII String Normalization Engine', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        TextField(
          controller: _inputCtrl,
          decoration: const InputDecoration(
            labelText: 'Raw PII String Input',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Normalized Output: "$_normalized"',
            style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _normalizeString,
            icon: const Icon(Icons.cleaning_services),
            label: const Text('NORMALIZE PII STRING'),
          ),
        ),
      ],
    );
  }
}
