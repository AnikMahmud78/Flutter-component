// lib/widgets/date_masked_text_field.dart
// Task GEN-00068: Schema-Driven Input Mask Props for Date Types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateMaskedTextField extends StatefulWidget {
  const DateMaskedTextField({super.key});

  @override
  State<DateMaskedTextField> createState() => _DateMaskedTextFieldState();
}

class _DateMaskedTextFieldState extends State<DateMaskedTextField> {
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: TextFormField(
              controller: _dateController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _DateInputFormatter(),
              ],
              decoration: const InputDecoration(
                labelText: 'Date Input (YYYY-MM-DD)',
                hintText: '2026-09-16',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              validator: (val) {
                if (val == null || val.length != 10) {
                  return 'Invalid date payload format';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 48.0,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48.0)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Date Input Mask Passed Validation!')),
                  );
                }
              },
              child: const Text('VALIDATE DATE SCHEMA'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length > 8) return oldValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 3 || i == 5) && i != text.length - 1) {
        buffer.write('-');
      }
    }
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
