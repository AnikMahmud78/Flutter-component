// lib/widgets/design_token_compilation_card.dart
import 'package:flutter/material.dart';

class DesignTokenCompilationCard extends StatelessWidget {
  const DesignTokenCompilationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Master JSON Design Tokens Compiler', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('tokens.json -> Dart Theme Tokens'),
          subtitle: const Text('Compilation Success Rate: 100% | Dart theme variables active'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.code),
            label: const Text('RECOMPILE DESIGN TOKENS'),
          ),
        ),
      ],
    );
  }
}
