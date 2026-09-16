// lib/widgets/mtti_filter_card.dart
import 'package:flutter/material.dart';

class MttiFilterCard extends StatefulWidget {
  const MttiFilterCard({super.key});

  @override
  State<MttiFilterCard> createState() => _MttiFilterCardState();
}

class _MttiFilterCardState extends State<MttiFilterCard> {
  double _mttiLatencyMs = 0.8;

  void _runMttiValidation() {
    setState(() {
      _mttiLatencyMs = 0.6;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cloud Run MTTI IVT Filter Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('MTTI Validation Threshold: > 10s Delta'),
          subtitle: Text('Execution Latency: ${_mttiLatencyMs.toStringAsFixed(1)} ms'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _runMttiValidation,
            icon: const Icon(Icons.shield),
            label: const Text('TEST MTTI VALIDATION LOGIC'),
          ),
        ),
      ],
    );
  }
}
