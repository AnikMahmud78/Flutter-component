import 'package:flutter/material.dart';

class VirtualNodeItem extends StatelessWidget {
  final int index;

  const VirtualNodeItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text('Virtual List Node #$index'),
        subtitle: const Text('State: Active in Viewport (Off-screen nodes disposed)'),
        trailing: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          child: IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
