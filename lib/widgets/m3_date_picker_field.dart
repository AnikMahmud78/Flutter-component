import 'package:flutter/material.dart';

class M3DatePickerField extends StatefulWidget {
  final String labelText;
  final ValueChanged<DateTime> onDateSelected;

  const M3DatePickerField({
    super.key,
    required this.labelText,
    required this.onDateSelected,
  });

  @override
  State<M3DatePickerField> createState() => _M3DatePickerFieldState();
}

class _M3DatePickerFieldState extends State<M3DatePickerField> {
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickDate,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          _selectedDate == null
              ? 'Select date'
              : '\${_selectedDate!.year}-\${_selectedDate!.month.toString().padLeft(2, '0')}-\${_selectedDate!.day.toString().padLeft(2, '0')}',
        ),
      ),
    );
  }
}
