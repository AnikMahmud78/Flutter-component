import 'package:flutter/material.dart';

class InputFieldGroup extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? helperText;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const InputFieldGroup({
    super.key,
    required this.labelText,
    required this.hintText,
    this.helperText,
    this.validator,
    required this.controller,
  });

  @override
  State<InputFieldGroup> createState() => _InputFieldGroupState();
}

class _InputFieldGroupState extends State<InputFieldGroup> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8.0),
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: _isFocused
                ? theme.colorScheme.primaryContainer.withOpacity(0.15)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: widget.hintText,
                helperText: widget.helperText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
