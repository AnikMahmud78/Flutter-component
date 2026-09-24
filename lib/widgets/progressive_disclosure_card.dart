import 'package:flutter/material.dart';
import '../models/progressive_disclosure_model.dart';

class ProgressiveDisclosureCard extends StatelessWidget {
  final ProgressiveDisclosureModel model;
  final ValueChanged<bool> onExpansionChanged;

  const ProgressiveDisclosureCard({
    Key? key,
    required this.model,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ExpansionTile(
        title: Text('Single-Action Progressive Step', style: theme.textTheme.titleMedium),
        subtitle: const Text('Tap to reveal advanced configuration parameters'),
        initiallyExpanded: model.isExpanded,
        onExpansionChanged: onExpansionChanged,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Secondary details revealed via progressive disclosure.'),
                const SizedBox(height: 12.0),
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Single Primary Action Executed')),
                      );
                    },
                    child: const Text('Complete Primary Action'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
