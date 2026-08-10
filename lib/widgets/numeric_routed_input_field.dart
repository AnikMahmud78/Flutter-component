import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../formatters/numeric_currency_formatter.dart';

/// Universal Numeric Routed Input Field Component
class NumericRoutedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String helperText;
  final String? errorText;
  final bool isDecimalAllowed;
  final ValueChanged<String> onChanged;

  const NumericRoutedInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.helperText,
    this.errorText,
    this.isDecimalAllowed = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          // REQUIREMENT: Inject explicit numeric/decimal keypad routing
          keyboardType: TextInputType.numberWithOptions(
            decimal: isDecimalAllowed,
            signed: false,
          ),
          onChanged: onChanged,
          // REQUIREMENT: Real-time text block filters to drop non-numeric inputs immediately
          inputFormatters: [
            if (isDecimalAllowed)
              NumericCurrencyFormatter()
            else
              FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            // REQUIREMENT: Material Design focused & error outline tones
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? Colors.red : Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? Colors.red : Colors.blue,
                width: 2.0,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
            suffixIcon: Icon(
              hasError
                  ? Icons.error_outline
                  : (controller.text.isNotEmpty
                        ? Icons.check_circle
                        : Icons.numbers),
              color: hasError
                  ? Colors.red
                  : (controller.text.isNotEmpty ? Colors.green : Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 6),
        // REQUIREMENT: Render validation alerts / guidance directly beneath text underline
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            hasError ? errorText! : helperText,
            style: TextStyle(
              fontSize: 12,
              color: hasError ? Colors.red.shade700 : Colors.grey.shade600,
              fontWeight: hasError ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
