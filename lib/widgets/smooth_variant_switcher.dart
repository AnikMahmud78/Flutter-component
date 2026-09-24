import 'package:flutter/material.dart';

class SmoothVariantSwitcher extends StatelessWidget {
  final bool isCompactState;
  final Widget compactView;
  final Widget expandedView;

  const SmoothVariantSwitcher({
    super.key,
    required this.isCompactState,
    required this.compactView,
    required this.expandedView,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: compactView,
      secondChild: expandedView,
      crossFadeState: isCompactState ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
    );
  }
}
