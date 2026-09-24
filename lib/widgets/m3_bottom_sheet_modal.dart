import 'package:flutter/material.dart';

class M3BottomSheetModal extends StatelessWidget {
  const M3BottomSheetModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      builder: (context) => const M3BottomSheetModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            'Configuration Menu',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const IconButton(
              icon: Icon(Icons.palette_outlined),
              onPressed: null,
            ),
            title: const Text('Theme Settings'),
            subtitle: const Text('Customize Material You dynamic token palette'),
            trailing: IconButton(
              iconSize: 24,
              icon: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ),
          ListTile(
            leading: const IconButton(
              icon: Icon(Icons.security_outlined),
              onPressed: null,
            ),
            title: const Text('Access Control'),
            subtitle: const Text('Review permissions and token scopes'),
            trailing: IconButton(
              iconSize: 24,
              icon: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.tonal(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close Modal'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
