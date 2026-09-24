import 'package:flutter/material.dart';

class MtoWrapperByt extends StatelessWidget {
  final Widget child;
  const MtoWrapperByt({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }
}
