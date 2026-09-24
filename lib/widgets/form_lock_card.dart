import 'package:flutter/material.dart';
import '../models/form_lock_model.dart';

class FormLockCard extends StatelessWidget {
  final FormLockModel model;
  final ValueChanged<bool> onToggleValidity;
  final VoidCallback onSubmit;

  const FormLockCard({
    Key? key,
    required this.model,
    required this.onToggleValidity,
    required this.onSubmit,
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
            Text('Form State Lock Enforcer', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            SwitchListTile(
              title: const Text('Form Validation State'),
              subtitle: Text(model.isFormValid ? 'Valid (Submit Unlocked)' : 'Mismatched (Submit Locked)'),
              value: model.isFormValid,
              onChanged: onToggleValidity,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: model.isFormValid ? onSubmit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                child: const Text('Submit Form Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
