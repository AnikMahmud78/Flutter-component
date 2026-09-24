import 'package:flutter/material.dart';
import '../models/form_validation_state.dart';

class RequiredFieldsForm extends StatefulWidget {
  final Function(bool pass) onSubmitResult;

  const RequiredFieldsForm({super.key, required this.onSubmitResult});

  @override
  State<RequiredFieldsForm> createState() => _RequiredFieldsFormState();
}

class _RequiredFieldsFormState extends State<RequiredFieldsForm> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _employeeId = '';

  FormValidationState get _currentState => FormValidationState(
        isFullNameValid: _fullName.trim().isNotEmpty,
        isEmailValid: RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_email),
        isEmployeeIdValid: _employeeId.trim().length >= 4,
      );

  void _submit() {
    if (_formKey.currentState!.validate() && _currentState.isAllValid) {
      widget.onSubmitResult(true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submitted Successfully!')),
      );
    } else {
      widget.onSubmitResult(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = _currentState;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: state.completionRate,
                    color: state.isAllValid ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Completion Rate: ${(state.completionRate * 100).toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full Name *',
              border: OutlineInputBorder(),
              helperText: 'Required field',
            ),
            onChanged: (val) => setState(() => _fullName = val),
            validator: (val) => val == null || val.isEmpty ? 'Full name is required' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Work Email *',
              border: OutlineInputBorder(),
              helperText: 'Required valid email',
            ),
            onChanged: (val) => setState(() => _email = val),
            validator: (val) => !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val ?? '')
                ? 'Valid email required'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Employee ID *',
              border: OutlineInputBorder(),
              helperText: 'At least 4 characters',
            ),
            onChanged: (val) => setState(() => _employeeId = val),
            validator: (val) => (val?.length ?? 0) < 4 ? 'Min 4 characters required' : null,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: state.isAllValid ? _submit : null,
              child: const Text('Submit Data'),
            ),
          ),
        ],
      ),
    );
  }
}
