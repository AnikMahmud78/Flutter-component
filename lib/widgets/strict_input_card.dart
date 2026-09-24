import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/strict_input_model.dart';

class StrictInputCard extends StatelessWidget {
  final StrictInputModel model;
  final ValueChanged<String> onChanged;

  const StrictInputCard({
    Key? key,
    required this.model,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Strict Numeric Input Component', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Numeric Code Only',
                prefixIcon: Icon(Icons.pin),
              ),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
