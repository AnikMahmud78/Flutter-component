// lib/widgets/addon_exclusion_card.dart
import 'package:flutter/material.dart';

class AddonExclusionCard extends StatefulWidget {
  const AddonExclusionCard({super.key});

  @override
  State<AddonExclusionCard> createState() => _AddonExclusionCardState();
}

class _AddonExclusionCardState extends State<AddonExclusionCard> {
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mutually Exclusive Add-On Logic', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        RadioListTile<String>(
          title: const Text('Basic Clean (2hrs)'),
          subtitle: const Text('Standard service package'),
          value: 'basic',
          groupValue: _selected,
          onChanged: (v) => setState(() => _selected = v!),
        ),
        RadioListTile<String>(
          title: const Text('Deep Clean (4hrs)'),
          subtitle: const Text('Mutually exclusive with Basic'),
          value: 'deep',
          groupValue: _selected,
          onChanged: (v) => setState(() => _selected = v!),
        ),
        RadioListTile<String>(
          title: Text('Express Clean (1hr)', style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.5))),
          subtitle: const Text('Disabled: incompatible with add-ons'),
          value: 'express',
          groupValue: _selected,
          onChanged: null,
        ),
      ],
    );
  }
}
