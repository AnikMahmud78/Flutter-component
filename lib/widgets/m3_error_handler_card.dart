import 'package:flutter/material.dart';
import '../models/m3_error_handler_model.dart';

class M3ErrorHandlerCard extends StatelessWidget {
  final M3ErrorHandlerModel model;
  final VoidCallback onTriggerError;

  const M3ErrorHandlerCard({
    Key? key,
    required this.model,
    required this.onTriggerError,
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
            Text('M3 Error Handling Guidelines', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Account Username',
                errorText: model.errorMessage,
                errorStyle: TextStyle(color: theme.colorScheme.error),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: OutlinedButton(
                onPressed: onTriggerError,
                child: Text(model.hasError ? 'Clear Error' : 'Trigger MD3 Error State'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
