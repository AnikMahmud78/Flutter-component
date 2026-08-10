import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../formatters/card_number_formatter.dart';

/// Reusable Masked Card Input Component
class MaskedCardInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool isValid;

  const MaskedCardInput({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Blocks non-numbers
        LengthLimitingTextInputFormatter(16), // Ceiling limit: 16 digits
        CardNumberFormatter(), // Custom 4-4-4-4 spacing
      ],
      decoration: InputDecoration(
        labelText: 'Card Number',
        hintText: '0000 0000 0000 0000',
        helperText: 'Enter a valid 16-digit card number',
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isValid ? Colors.green : Colors.blue,
            width: 2.0,
          ),
        ),
        suffixIcon: Icon(
          isValid ? Icons.check_circle : Icons.credit_card,
          color: isValid ? Colors.green : Colors.grey,
        ),
      ),
      validator: (value) {
        final cleanValue = value?.replaceAll(' ', '') ?? '';
        if (cleanValue.length < 16) {
          return 'Card number must be exactly 16 digits';
        }
        return null;
      },
    );
  }
}
