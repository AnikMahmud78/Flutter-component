import 'package:flutter/material.dart';
import '../models/ui_acknowledgement_model.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  final UiAcknowledgementModel model;
  final VoidCallback onTriggerConfirm;

  const ConfirmationDialogWidget({
    super.key,
    required this.model,
    required this.onTriggerConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MD3 Confirmation Gate', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('User Confirmation Logged: ${model.userConfirmed ? "YES" : "NO"}'),
            Text('Snackbar Feedback Displayed: ${model.feedbackDisplayed ? "YES" : "NO"}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: ElevatedButton.icon(
                onPressed: onTriggerConfirm,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Trigger Action with MD3 Confirmation'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
