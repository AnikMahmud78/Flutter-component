// lib/widgets/special_requirements_card.dart
import 'package:flutter/material.dart';

class SpecialRequirementsCard extends StatefulWidget {
  const SpecialRequirementsCard({super.key});

  @override
  State<SpecialRequirementsCard> createState() => _SpecialRequirementsCardState();
}

class _SpecialRequirementsCardState extends State<SpecialRequirementsCard> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Special Requirements / Allergies Field', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        TextField(
          controller: _controller,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Special Requirements / Allergies (Optional)',
            hintText: 'e.g. Pet allergy, fragrance-free products only...',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.warning_amber_outlined),
          ),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Requirements saved: ${_controller.text.isEmpty ? "None" : _controller.text}')),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text('SAVE SPECIAL REQUIREMENTS'),
          ),
        ),
      ],
    );
  }
}
