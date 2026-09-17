// lib/widgets/touch_filter_controls_card.dart
import 'package:flutter/material.dart';

class TouchFilterControlsCard extends StatefulWidget {
  const TouchFilterControlsCard({super.key});

  @override
  State<TouchFilterControlsCard> createState() => _TouchFilterControlsCardState();
}

class _TouchFilterControlsCardState extends State<TouchFilterControlsCard> {
  double _price = 250;
  bool _inStock = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('M3 Touch Filter Controls', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        Text('Max Price: AED ${_price.toInt()}', style: theme.textTheme.bodyMedium),
        Slider(
          value: _price,
          min: 50,
          max: 1000,
          onChanged: (v) => setState(() => _price = v),
        ),
        const SizedBox(height: 8.0),
        FilterChip(
          label: const Text('In Stock Only'),
          selected: _inStock,
          onSelected: (v) => setState(() => _inStock = v),
        ),
      ],
    );
  }
}
