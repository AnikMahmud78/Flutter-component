// lib/widgets/schema_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SchemaTextField extends StatefulWidget {
  final String label;

  const SchemaTextField({super.key, required this.label});

  @override
  State<SchemaTextField> createState() => _SchemaTextFieldState();
}

class _SchemaTextFieldState extends State<SchemaTextField> {
  final TextEditingController _controller = TextEditingController();

  // State Handler Embedded Formatter Logic
  TextInputFormatter _getEmbeddedMaskFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text.replaceAll(RegExp(r'\D'), '');
      if (text.length > 8) return oldValue;
      final buffer = StringBuffer();
      for (int i = 0; i < text.length; i++) {
        buffer.write(text[i]);
        if ((i == 1 || i == 3) && i != text.length - 1) {
          buffer.write('/');
        }
      }
      final str = buffer.toString();
      return newValue.copyWith(
        text: str,
        selection: TextSelection.collapsed(offset: str.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [_getEmbeddedMaskFormatter()],
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: 'MM/DD/YYYY',
              border: const OutlineInputBorder(),
              suffixIcon: const Icon(Icons.pin),
            ),
          ),
        ),
      ],
    );
  }
}
