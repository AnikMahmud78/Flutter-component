import 'package:flutter/material.dart';
import '../models/add_on_selector_model.dart';

class AddOnSelectorCard extends StatelessWidget {
  final AddOnSelectorModel model;
  final ValueChanged<bool> onToggle;

  const AddOnSelectorCard({
    Key? key,
    required this.model,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(
              width: 48.0,
              height: 48.0,
              child: Checkbox(
                value: model.isSelected,
                onChanged: (val) => onToggle(val ?? false),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.addOnTitle,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text('@habot/checkout/add-on-selector', style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            Text(
              '+\\$\${model.price.toStringAsFixed(2)}',
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
