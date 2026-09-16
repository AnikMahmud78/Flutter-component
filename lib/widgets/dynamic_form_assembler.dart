import 'package:flutter/material.dart';
import '../models/dynamic_form_model.dart';

class DynamicFormAssembler extends StatefulWidget {
  final List<FieldDescriptor> schema;
  final Function(Map<String, dynamic>) onSubmit;

  const DynamicFormAssembler({
    super.key,
    required this.schema,
    required this.onSubmit,
  });

  @override
  State<DynamicFormAssembler> createState() => _DynamicFormAssemblerState();
}

class _DynamicFormAssemblerState extends State<DynamicFormAssembler> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...widget.schema.map((field) => _buildField(field, theme, width)),
          const SizedBox(height: 24.0),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSubmit(_formData);
                }
              },
              child: const Text('SUBMIT DATA FORM'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(FieldDescriptor field, ThemeData theme, double screenWidth) {
    final paddingBottom = screenWidth < 600 ? 16.0 : 24.0;
    
    Widget inputWidget;
    switch (field.type) {
      case FieldType.text:
      case FieldType.number:
        inputWidget = TextFormField(
          keyboardType: field.type == FieldType.number 
              ? TextInputType.number 
              : TextInputType.text,
          decoration: InputDecoration(
            labelText: field.label,
            hintText: field.placeholder ?? 'Enter ${field.label.toLowerCase()}',
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          ),
          validator: (val) {
            if (field.isRequired && (val == null || val.trim().isEmpty)) {
              return '${field.label} is required';
            }
            return null;
          },
          onSaved: (val) => _formData[field.key] = val,
        );
        break;
      case FieldType.toggle:
        inputWidget = Container(
          height: 48.0,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(field.label, style: theme.textTheme.bodyMedium),
              Switch(
                value: _formData[field.key] ?? false,
                onChanged: (val) {
                  setState(() => _formData[field.key] = val);
                },
              ),
            ],
          ),
        );
        break;
      case FieldType.dropdown:
        inputWidget = DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: field.label,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          items: (field.options ?? []).map((opt) {
            return DropdownMenuItem(value: opt, child: Text(opt));
          }).toList(),
          validator: (val) {
            if (field.isRequired && (val == null || val.isEmpty)) {
              return 'Selection required for ${field.label}';
            }
            return null;
          },
          onChanged: (val) => _formData[field.key] = val,
        );
        break;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48.0),
        child: inputWidget,
      ),
    );
  }
}
