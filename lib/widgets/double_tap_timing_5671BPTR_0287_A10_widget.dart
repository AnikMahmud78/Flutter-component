import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AtomicDoubleTap5671BPTR0287A10Widget extends StatefulWidget {
  final Widget child;
  final VoidCallback onDoubleTap;

  const AtomicDoubleTap5671BPTR0287A10Widget({
    super.key,
    required this.child,
    required this.onDoubleTap,
  });

  @override
  State<AtomicDoubleTap5671BPTR0287A10Widget> createState() =>
      _AtomicDoubleTap5671BPTR0287A10WidgetState();
}

class _AtomicDoubleTap5671BPTR0287A10WidgetState
    extends State<AtomicDoubleTap5671BPTR0287A10Widget> {
  DateTime? _lastTap;

  void _handleTap() {
    final now = DateTime.now();
    if (_lastTap != null &&
        now.difference(_lastTap!) < const Duration(milliseconds: 250)) {
      HapticFeedback.lightImpact();
      widget.onDoubleTap();
      _lastTap = null;
      return;
    }
    _lastTap = now;
  }

  @override
  Widget build(BuildContext context) =>
      GestureDetector(onTap: _handleTap, child: widget.child);
}
