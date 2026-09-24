import 'package:flutter/material.dart';
import '../models/keyring_manager_model.dart';

class KeyringManagerCard extends StatelessWidget {
  final KeyringManagerModel model;
  final VoidCallback onInitializeKey;

  const KeyringManagerCard({
    Key? key,
    required this.model,
    required this.onInitializeKey,
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
            Text('OS Keyring Storage Manager', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Alias: ${model.keyAlias}'),
            const SizedBox(height: 8.0),
            Chip(
              avatar: const Icon(Icons.security, color: Colors.green),
              label: Text(model.isKeyBoundToHardware ? 'Hardware Key Store Active' : 'Software Key'),
              backgroundColor: Colors.green.shade50,
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onInitializeKey,
                icon: const Icon(Icons.key),
                label: const Text('Provision Encrypted SQLite Key'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
