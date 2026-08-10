import 'package:flutter/services.dart';

/// Formatter that allows numeric entries with up to 2 decimal places (e.g., $1250.50)
class NumericCurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new value contains non-numeric/non-decimal characters, drop them
    final regEx = RegExp(r'^\d*\.?\d{0,2}');
    final String newString = regEx.stringMatch(newValue.text) ?? '';

    if (newString == newValue.text) {
      return newValue;
    }

    return oldValue;
  }
}
