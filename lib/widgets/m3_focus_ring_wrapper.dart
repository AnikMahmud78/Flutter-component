import 'package:flutter/material.dart';

class M3FocusRingWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const M3FocusRingWrapper({Key? key, required this.child, required this.onTap}) : super(key: key);

  @override
  State<M3FocusRingWrapper> createState() => _M3FocusRingWrapperState();
}

class _M3FocusRingWrapperState extends State<M3FocusRingWrapper> {
  bool _isFocused = false;

  // English Code (EC): Render-M3-Focus-Ring
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Focus(
      onFocusChange: (focused) {
        setState(() {
          _isFocused = focused;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: _isFocused ? theme.colorScheme.secondary : Colors.transparent,
              width: 3.0,
            ),
          ),
          padding: const EdgeInsets.all(2.0), // Offset spacing
          child: widget.child,
        ),
      ),
    );
  }
}
