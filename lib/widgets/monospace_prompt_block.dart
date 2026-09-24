import 'package:flutter/material.dart';

class MonospacePromptBlock extends StatelessWidget {
  final String promptText;

  const MonospacePromptBlock({
    Key? key,
    required this.promptText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: SelectableText(
        promptText,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 14.0,
          height: 1.5,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
