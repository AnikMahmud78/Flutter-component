import 'package:flutter/material.dart';
import '../models/required_field_tokens.dart';

class RequiredFormFieldBuilder extends StatelessWidget {
  final String label;
  final String hintText;
  final String? helperText;
  final bool isMandatory;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const RequiredFormFieldBuilder({
    super.key,
    required this.label,
    required this.hintText,
    this.helperText,
    this.isMandatory = true,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Standard spatial gap
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LABEL HEADER WITH HIGH-CONTRAST RED ASTERISK (*)
          Row(
            children: [
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              if (isMandatory) ...[
                const SizedBox(width: 4.0),
                Text(
                  RequiredFieldTokens().tokenValues['asteriskSymbol'] as String,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: RequiredFieldTokens.m3SemanticRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 6.0), // 6px spatial gap to input box
          // TEXT INPUT CONTROL WITH MINIMUM 48DP TOUCH TARGET
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator:
                  validator ??
                  (value) {
                    if (isMandatory &&
                        (value == null || value.trim().isEmpty)) {
                      return '$label is required.';
                    }
                    return null;
                  },
              decoration: InputDecoration(
                hintText: hintText,
                helperText: helperText,
                helperStyle: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: RequiredFieldTokens.m3SemanticRed,
                    width: 1.5,
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: RequiredFieldTokens.m3SemanticRed,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
