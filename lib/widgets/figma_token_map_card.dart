import 'package:flutter/material.dart';
import '../models/figma_token_map_model.dart';

class FigmaTokenMapCard extends StatelessWidget {
  final FigmaTokenMapModel model;
  final VoidCallback onSyncTokens;

  const FigmaTokenMapCard({
    Key? key,
    required this.model,
    required this.onSyncTokens,
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
            Text('Figma Token Sync Mapper', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Figma Doc ID: \${model.figmaFileId}'),
            Text('Pixel Fidelity Rate: \${model.mappingCompletionRate.toStringAsFixed(1)}%'),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton.icon(
                onPressed: onSyncTokens,
                icon: const Icon(Icons.sync_alt),
                label: const Text('Sync Tokens with Codebase'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
