import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CdeInputMask479BPTR0303A03Widget extends StatefulWidget {
  const CdeInputMask479BPTR0303A03Widget({super.key});

  @override
  State<CdeInputMask479BPTR0303A03Widget> createState() =>
      _CdeInputMask479BPTR0303A03WidgetState();
}

class _CdeInputMask479BPTR0303A03WidgetState
    extends State<CdeInputMask479BPTR0303A03Widget> {
  bool _invalid = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      onChanged: (value) =>
          setState(() => _invalid = (double.tryParse(value) ?? 0) > 1000000),
      decoration: InputDecoration(
        labelText: 'Transaction amount (USD)',
        prefixText: '\$ ',
        errorText: _invalid ? 'Amount exceeds maximum threshold' : null,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
