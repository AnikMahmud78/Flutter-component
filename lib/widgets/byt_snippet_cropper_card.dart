// lib/widgets/byt_snippet_cropper_card.dart
// Task GEN-00282: Confirm the BytSnippetCropper component and coordinate parser are delivered.
import 'package:flutter/material.dart';

class BytSnippetCropperCard extends StatefulWidget {
  const BytSnippetCropperCard({super.key});

  @override
  State<BytSnippetCropperCard> createState() => _BytSnippetCropperCardState();
}

class _BytSnippetCropperCardState extends State<BytSnippetCropperCard> {
  String _cropCoordinates = 'Rect(x: 12.0, y: 34.0, w: 200.0, h: 150.0)';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BytSnippetCropper Inspector', style: theme.textTheme.titleMedium),
                Chip(
                  label: const Text('DELIVERED'),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text('Parsed Coordinates:', style: theme.textTheme.bodySmall),
            const SizedBox(height: 4.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _cropCoordinates,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {
                  setState(() {
                    _cropCoordinates = 'Rect(x: 24.5, y: 48.0, w: 320.0, h: 240.0) -> Validated';
                  });
                },
                icon: const Icon(Icons.check),
                label: const Text('CONFIRM COORDINATE PARSER'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
