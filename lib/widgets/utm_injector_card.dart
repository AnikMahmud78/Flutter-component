// lib/widgets/utm_injector_card.dart
import 'package:flutter/material.dart';

class UtmInjectorCard extends StatefulWidget {
  const UtmInjectorCard({super.key});

  @override
  State<UtmInjectorCard> createState() => _UtmInjectorCardState();
}

class _UtmInjectorCardState extends State<UtmInjectorCard> {
  String _shortUrl = 'https://habot.li/m/8840192';

  void _generateShortenedLink() {
    setState(() {
      _shortUrl = 'https://habot.li/m/8840192?utm_source=app&utm_medium=push&utm_campaign=retention&trace_id=TRC-9901';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Branded Link Shortener & UTM Generator', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Generated Branded Link:'),
          subtitle: Text(_shortUrl, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
          trailing: Icon(Icons.content_copy, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _generateShortenedLink,
            icon: const Icon(Icons.add_link),
            label: const Text('GENERATE UTM SHORT LINK'),
          ),
        ),
      ],
    );
  }
}
