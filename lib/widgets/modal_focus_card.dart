import 'package:flutter/material.dart';
import '../models/modal_focus_model.dart';

class ModalFocusCard extends StatelessWidget {
  final ModalFocusModel model;
  final VoidCallback onOpenModal;

  const ModalFocusCard({
    Key? key,
    required this.model,
    required this.onOpenModal,
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
            Text('Modal Focus Management', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            const Text('Focus Trapping ensures screen readers do not exit active modals.'),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: onOpenModal,
                child: const Text('Open Focus-Bounded Modal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
