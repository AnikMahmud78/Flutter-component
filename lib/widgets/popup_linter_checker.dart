// lib/widgets/popup_linter_checker.dart
import 'package:flutter/material.dart';

class PopupLinterChecker extends StatefulWidget {
  const PopupLinterChecker({super.key});

  @override
  State<PopupLinterChecker> createState() => _PopupLinterCheckerState();
}

class _PopupLinterCheckerState extends State<PopupLinterChecker> {
  bool _linterWarningTriggered = true;

  void _testMobileBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => Container(
        padding: const EdgeInsets.all(16.0),
        height: 180,
        child: Column(
          children: [
            Text('Ergonomic M3 Bottom Sheet', style: Theme.of(bCtx).textTheme.titleMedium),
            const SizedBox(height: 12.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
              onPressed: () => Navigator.pop(bCtx),
              child: const Text('DISMISS SHEET'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Centered Popup Linter Gate (<600px)', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'LINTER WARNING: Centered Dialogs banned on <600dp viewports. Use M3 Bottom Sheet.',
                style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () => _testMobileBottomSheet(context),
                icon: const Icon(Icons.vertical_align_bottom),
                label: const Text('TRIGGER COMPLIANT BOTTOM SHEET'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
