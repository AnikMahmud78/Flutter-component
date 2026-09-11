// CSIVW-003-A09 — Quantitative Rating Input Element Design: Real-time validation for out-of-range values
import 'package:flutter/material.dart';

class RatingInputValidationWidget extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double? initialValue;
  final ValueChanged<double>? onValidValueChanged;

  const RatingInputValidationWidget({
    super.key,
    required this.minValue,
    required this.maxValue,
    this.initialValue,
    this.onValidValueChanged,
  });

  @override
  State<RatingInputValidationWidget> createState() => _RatingInputValidationWidgetState();
}

class _RatingInputValidationWidgetState extends State<RatingInputValidationWidget> {
  late TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue?.toString() ?? '');
    _validate(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validate(String value) {
    final double? parsed = double.tryParse(value);
    if (parsed == null) {
      setState(() {
        _errorText = 'Please enter a number';
      });
      return;
    }
    if (parsed < widget.minValue || parsed > widget.maxValue) {
      setState(() {
        _errorText = 'Value must be between ${widget.minValue} and ${widget.maxValue}';
      });
    } else {
      setState(() {
        _errorText = null;
      });
      widget.onValidValueChanged?.call(parsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Rating',
        errorText: _errorText,
        border: const OutlineInputBorder(),
      ),
      onChanged: _validate,
    );
  }
}
