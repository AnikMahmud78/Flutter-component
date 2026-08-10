import 'package:flutter/material.dart';

/// Accessibility-approved touch-target padding helper shell.
/// Enforces a strict minimum touch profile of 48x48dp across all clickable components.
class ErgonomicTouchTarget extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final String? semanticsLabel;
  final bool showDebugTargetBox;

  const ErgonomicTouchTarget({
    super.key,
    required this.child,
    required this.onTap,
    this.semanticsLabel,
    this.showDebugTargetBox = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            // REQUIREMENT: Show visual 48x48dp border during debugging/audit
            decoration: showDebugTargetBox
                ? BoxDecoration(
                    border: Border.all(color: Colors.red.shade300, width: 1.0),
                    color: Colors.red.withAlpha(15),
                  )
                : null,
            child: ConstrainedBox(
              // REQUIREMENT: Enforce strict minimum touch size profile of 48x48dp
              constraints: const BoxConstraints(
                minWidth: 48.0,
                minHeight: 48.0,
              ),
              child: Center(widthFactor: 1.0, heightFactor: 1.0, child: child),
            ),
          ),
        ),
      ),
    );
  }
}
