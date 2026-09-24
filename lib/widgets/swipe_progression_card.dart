import 'package:flutter/material.dart';
import '../models/swipe_progression_model.dart';

class SwipeProgressionCard extends StatelessWidget {
  final SwipeProgressionModel model;
  final ValueChanged<bool> onToggleActionState;

  const SwipeProgressionCard({
    Key? key,
    required this.model,
    required this.onToggleActionState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Swipe Progression Lock Gate', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            SwitchListTile(
              title: const Text('Required Step Action'),
              subtitle: Text(model.isSingleActionValid ? 'Action Complete (Swipe Allowed)' : 'Action Invalid (Swipe Disabled)'),
              value: model.isSingleActionValid,
              onChanged: onToggleActionState,
            ),
          ],
        ),
      ),
    );
  }
}
