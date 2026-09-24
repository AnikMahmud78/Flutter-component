import 'package:flutter/material.dart';

class CenteredFocusInput extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;

  const CenteredFocusInput({
    super.key,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          textAlign: TextAlign.center,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
        ),
      ),
    );
  }
}
