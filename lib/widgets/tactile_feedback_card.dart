import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/tactile_feedback_model.dart';

class TactileFeedbackCard extends StatelessWidget {
  final TactileFeedbackModel model;
  final ValueChanged<bool> onSelectionChanged;

  const TactileFeedbackCard({
    Key? key,
    required this.model,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      color: model.isSelected ? theme.colorScheme.primaryContainer : theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: model.isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
          width: model.isSelected ? 2.5 : 1.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          HapticFeedback.selectionClick();
          onSelectionChanged(!model.isSelected);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tactile High-Contrast Item',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: model.isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                model.isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: model.isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
