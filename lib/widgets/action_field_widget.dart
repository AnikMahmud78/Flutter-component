import 'package:flutter/material.dart';
import '../models/field_subtext_model.dart';

class ActionFieldWidget extends StatelessWidget {
  final FieldSubtextModel model;

  const ActionFieldWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Target System Trace ID',
                border: const OutlineInputBorder(),
                helperText: model.actionableSubtext,
                helperMaxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
