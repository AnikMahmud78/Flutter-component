// FIEVR-018-A07 — Single-Field Form Screen with Canonical Schema Integrity Guard.
// Restricts a form screen to render only the single transaction field assigned to the
// active task; unassigned fields are blocked at the gateway (poka-yoke) and field
// integrity is validated against the canonical schema (floor 95%, optimal 100%).

import 'package:flutter/material.dart';

/// Canonical type for a transaction data field.
enum CanonicalFieldType { text, number, decimal, date, boolean, selection }

/// Canonical schema definition for a single form field.
///
/// Field names, types and constraints trace back to this single canonical
/// schema so downstream reporting never has to reconcile naming drift.
class CanonicalFieldSchema {
  const CanonicalFieldSchema({
    required this.fieldName,
    required this.type,
    required this.label,
    this.hint,
    this.isRequired = true,
    this.maxLength,
    this.options = const <String>[],
  });

  final String fieldName;
  final CanonicalFieldType type;
  final String label;
  final String? hint;
  final bool isRequired;
  final int? maxLength;
  final List<String> options;

  /// Validates that a proposed field mapping matches this canonical schema.
  bool matchesMapping({required String proposedName, required CanonicalFieldType proposedType}) {
    return proposedName == fieldName && proposedType == type;
  }
}

/// Result of a field-integrity validation pass.
class FieldIntegrityResult {
  const FieldIntegrityResult({
    required this.totalFields,
    required this.matchedFields,
    required this.accuracy,
    required this.passed,
  });

  final int totalFields;
  final int matchedFields;

  /// Ratio of fields correctly named/typed (0.0 – 1.0).
  final double accuracy;

  /// Pass/Fail against the floor boundary of 95%.
  final bool passed;

  static const double floorBoundary = 0.95;
  static const double optimalTarget = 1.0;
}

/// Validates field mappings against the canonical schema registry.
///
/// Metric: Data Field Integrity & Mapping Accuracy.
/// Floor: 95% of fields correctly named/typed.
/// Optimal: 100% match to the canonical schema definition.
class FieldIntegrityValidator {
  const FieldIntegrityValidator(this.canonicalSchema);

  final List<CanonicalFieldSchema> canonicalSchema;

  FieldIntegrityResult validate(
    List<({String name, CanonicalFieldType type})> proposedMappings,
  ) {
    if (proposedMappings.isEmpty) {
      return const FieldIntegrityResult(
        totalFields: 0,
        matchedFields: 0,
        accuracy: 1.0,
        passed: true,
      );
    }
    var matched = 0;
    for (final mapping in proposedMappings) {
      final canonical = canonicalSchema.where((s) => s.fieldName == mapping.name);
      if (canonical.isNotEmpty &&
          canonical.first.matchesMapping(proposedName: mapping.name, proposedType: mapping.type)) {
        matched++;
      }
    }
    final accuracy = matched / proposedMappings.length;
    return FieldIntegrityResult(
      totalFields: proposedMappings.length,
      matchedFields: matched,
      accuracy: accuracy,
      passed: accuracy >= FieldIntegrityResult.floorBoundary,
    );
  }
}

/// Gateway that blocks access to any field outside the active task boundary.
///
/// Poka-yoke: data queries that exceed assigned task boundaries are denied,
/// so unassigned fields fail to load across client targets.
class TaskFieldAccessGateway {
  const TaskFieldAccessGateway({required this.assignedFieldName});

  /// The single field assigned to the active task.
  final String assignedFieldName;

  /// Returns the schema only when [fieldName] is within the task boundary;
  /// otherwise returns null (masked) and the attempt can be logged as a
  /// data-leakage attempt by the caller's telemetry layer.
  CanonicalFieldSchema? resolve(String fieldName, List<CanonicalFieldSchema> registry) {
    if (fieldName != assignedFieldName) return null;
    for (final schema in registry) {
      if (schema.fieldName == fieldName) return schema;
    }
    return null;
  }
}

/// A focused form screen that displays only the single field required for
/// the active task, protecting sensitive data and minimizing screen clutter.
///
/// The input block is placed directly beneath the optional cropped target
/// image area, keeping payloads small for mobile networks.
class SingleFieldFormScreen extends StatefulWidget {
  const SingleFieldFormScreen({
    super.key,
    required this.taskTitle,
    required this.assignedFieldName,
    required this.schemaRegistry,
    this.croppedImage,
    this.onSubmit,
    this.onAccessDenied,
  });

  /// Title of the active task shown in the app bar.
  final String taskTitle;

  /// The single transaction field exposed for this task.
  final String assignedFieldName;

  /// Canonical schema registry used to resolve and validate the field.
  final List<CanonicalFieldSchema> schemaRegistry;

  /// Optional cropped target image displayed next to the input block.
  final Widget? croppedImage;

  /// Called with the entered value when the form validates and submits.
  final ValueChanged<String>? onSubmit;

  /// Called when a field outside the task boundary is requested.
  final VoidCallback? onAccessDenied;

  @override
  State<SingleFieldFormScreen> createState() => _SingleFieldFormScreenState();
}

class _SingleFieldFormScreenState extends State<SingleFieldFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  late final TaskFieldAccessGateway _gateway;
  CanonicalFieldSchema? _field;

  @override
  void initState() {
    super.initState();
    _gateway = TaskFieldAccessGateway(assignedFieldName: widget.assignedFieldName);
    _field = _gateway.resolve(widget.assignedFieldName, widget.schemaRegistry);
    if (_field == null) {
      widget.onAccessDenied?.call();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    final field = _field;
    if (field == null) return 'Field unavailable';
    final v = value?.trim() ?? '';
    if (field.isRequired && v.isEmpty) return '${field.label} is required';
    if (field.maxLength != null && v.length > field.maxLength!) {
      return '${field.label} must be at most ${field.maxLength} characters';
    }
    switch (field.type) {
      case CanonicalFieldType.number:
        if (v.isNotEmpty && int.tryParse(v) == null) return 'Enter a whole number';
        break;
      case CanonicalFieldType.decimal:
        if (v.isNotEmpty && double.tryParse(v) == null) return 'Enter a valid number';
        break;
      case CanonicalFieldType.date:
        if (v.isNotEmpty && DateTime.tryParse(v) == null) return 'Enter a valid date (YYYY-MM-DD)';
        break;
      case CanonicalFieldType.text:
      case CanonicalFieldType.boolean:
      case CanonicalFieldType.selection:
        break;
    }
    return null;
  }

  TextInputType _keyboardType(CanonicalFieldType type) {
    switch (type) {
      case CanonicalFieldType.number:
        return TextInputType.number;
      case CanonicalFieldType.decimal:
        return const TextInputType.numberWithOptions(decimal: true);
      case CanonicalFieldType.date:
        return TextInputType.datetime;
      case CanonicalFieldType.text:
      case CanonicalFieldType.boolean:
      case CanonicalFieldType.selection:
        return TextInputType.text;
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit?.call(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final field = _field;

    return Scaffold(
      appBar: AppBar(title: Text(widget.taskTitle)),
      body: SafeArea(
        child: field == null
            ? Center(
                child: Text(
                  'This field is not available for the active task.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.croppedImage != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: widget.croppedImage,
                        ),
                        const SizedBox(height: 16),
                      ],
                      TextFormField(
                        controller: _controller,
                        keyboardType: _keyboardType(field.type),
                        maxLength: field.maxLength,
                        decoration: InputDecoration(
                          labelText: field.label,
                          hintText: field.hint,
                          border: const OutlineInputBorder(),
                        ),
                        validator: _validate,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: _submit,
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
