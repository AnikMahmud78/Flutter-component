import 'package:flutter/material.dart';

class M3AssistiveTextField extends StatelessWidget {
  final String labelText;
  final String helperText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const M3AssistiveTextField({
    super.key,
    required this.labelText,
    required this.helperText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        helperText: helperText,
        helperMaxLines: 2,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
