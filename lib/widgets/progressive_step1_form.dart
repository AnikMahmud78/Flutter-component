import 'package:flutter/material.dart';

class ProgressiveStep1Form extends StatefulWidget {
  const ProgressiveStep1Form({super.key});

  @override
  State<ProgressiveStep1Form> createState() => _ProgressiveStep1FormState();
}

class _ProgressiveStep1FormState extends State<ProgressiveStep1Form> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
          ),
          const SizedBox(height: 12.0),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
          ),
          const SizedBox(height: 12.0),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Location Region',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: const [
                DropdownMenuItem(value: 'NA', child: Text('North America')),
                DropdownMenuItem(value: 'EU', child: Text('Europe')),
                DropdownMenuItem(value: 'APAC', child: Text('Asia Pacific')),
              ],
              onChanged: (v) => setState(() => _selectedLocation = v),
              validator: (v) => v == null ? 'Selection required' : null,
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 48.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48.0),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Step 1 Basic Profile Saved!')),
                  );
                }
              },
              child: const Text('CONTINUE TO STEP 2'),
            ),
          ),
        ],
      ),
    );
  }
}
