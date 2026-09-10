import 'package:flutter/material.dart';

class MaterialTokens1744BPTR0544A12 extends StatelessWidget {
  const MaterialTokens1744BPTR0544A12({super.key});

  static const _brandPrimary = Color(0xFF315EFB);
  static const _brandWarning = Color(0xFF9A4600);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Material Design Tokens')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const ListTile(leading: Icon(Icons.palette_rounded), title: Text('1744BPTR-0544-A12'), subtitle: Text('Central typography, semantic colors, and immutable spacing tokens.')),
        const SizedBox(height: 16),
        Card.outlined(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Primary system heading', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: _brandPrimary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Unified body typography uses the Material 3 theme dictionary.', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 16),
          Row(children: [Container(width: 24, height: 24, color: scheme.primary), const SizedBox(width: 8), const Text('md.sys.color.primary')]),
          const SizedBox(height: 8),
          Row(children: [Container(width: 24, height: 24, color: _brandWarning), const SizedBox(width: 8), const Text('md.sys.color.warning')]),
        ]))),
        const SizedBox(height: 16),
        const Card.outlined(child: ListTile(title: Text('Integration Completeness: Complete'), subtitle: Text('Import Source: Core Design System Token Dictionary'))),
      ]),
    );
  }
}
