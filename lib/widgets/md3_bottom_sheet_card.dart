// lib/widgets/md3_bottom_sheet_card.dart
import 'package:flutter/material.dart';

class Md3BottomSheetCard extends StatelessWidget {
  const Md3BottomSheetCard({super.key});

  void _showActionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('MD3 Standard Bottom Sheet', style: Theme.of(ctx).textTheme.titleMedium),
              const SizedBox(height: 16.0),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48.0),
                child: FilledButton(
                  style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('PRIMARY ACTION (≥48x48dp)'),
                ),
              ),
              const SizedBox(height: 8.0),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('DISMISS (≥48x48dp)'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MD3 Complex Action Flow Bottom-Sheet', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Bottom Sheet Primary & Dismiss Buttons'),
          subtitle: const Text('Touch Target Area: ≥ 48x48dp | WCAG 2.1 AA Compliant'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () => _showActionBottomSheet(context),
            icon: const Icon(Icons.open_in_browser),
            label: const Text('OPEN STANDARDIZED BOTTOM SHEET'),
          ),
        ),
      ],
    );
  }
}
