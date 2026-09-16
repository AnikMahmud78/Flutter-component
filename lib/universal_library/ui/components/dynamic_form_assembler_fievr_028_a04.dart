// FIEVR-028-A04 — DynamicFormAssembler: Dynamic Form Renderer Engine with structural validation.
// Ingests clean metadata instruction profiles and compiles only requested field descriptors into
// input blocks; any descriptor failing structural validation (unknown type, broken schema, or
// unrequested key) is stripped before render so absent fields can never manifest in the widget tree.

import 'package:flutter/material.dart';

/// Supported field descriptor types mapped by the renderer engine.
enum DynamicFieldType { text, number, email, password, dropdown, checkbox, date, multiline }

/// Immutable descriptor model for a single requested form field.
class DynamicFieldDescriptor {
  const DynamicFieldDescriptor({
    required this.key,
    required this.type,
    required this.label,
    this.placeholder,
    this.required = false,
    this.options = const <String>[],
    this.initialValue,
  });

  final String key;
  final DynamicFieldType type;
  final String label;
  final String? placeholder;
  final bool required;
  final List<String> options;
  final String? initialValue;

  /// Strict structural parser. Returns `null` when the incoming map reveals a
  /// broken schema or an unmapped field type (Poka-Yoke: invalid descriptors
  /// cannot physically manifest inside the client widget tree).
  static DynamicFieldDescriptor? tryParse(Map<String, dynamic> raw) {
    final key = raw['key'];
    final label = raw['label'];
    final typeRaw = raw['type'];
    if (key is! String || key.isEmpty) return null;
    if (label is! String || label.isEmpty) return null;
    if (typeRaw is! String) return null;

    final type = switch (typeRaw) {
      'text' => DynamicFieldType.text,
      'number' => DynamicFieldType.number,
      'email' => DynamicFieldType.email,
      'password' => DynamicFieldType.password,
      'dropdown' => DynamicFieldType.dropdown,
      'checkbox' => DynamicFieldType.checkbox,
      'date' => DynamicFieldType.date,
      'multiline' => DynamicFieldType.multiline,
      _ => null, // Unmapped field type → stripped (fallback behavior).
    };
    if (type == null) return null;

    final optionsRaw = raw['options'];
    final options = optionsRaw is List
        ? optionsRaw.whereType<String>().toList(growable: false)
        : const <String>[];
    if (type == DynamicFieldType.dropdown && options.isEmpty) return null;

    return DynamicFieldDescriptor(
      key: key,
      type: type,
      label: label,
      placeholder: raw['placeholder'] is String ? raw['placeholder'] as String : null,
      required: raw['required'] == true,
      options: options,
      initialValue: raw['initialValue'] is String ? raw['initialValue'] as String : null,
    );
  }
}

/// Result of the structural validation pass over an instruction profile.
class InstructionProfileValidation {
  const InstructionProfileValidation({
    required this.accepted,
    required this.strippedKeys,
  });

  /// Descriptors that passed structural validation and will be rendered.
  final List<DynamicFieldDescriptor> accepted;

  /// Keys (or raw type markers) stripped because they were not requested,
  /// unmapped, or structurally broken.
  final List<String> strippedKeys;

  bool get isClean => strippedKeys.isEmpty;
}

/// Structural validator enforcing absolute data blindness: only fields
/// explicitly requested by the instruction profile survive compilation.
class DynamicFormValidator {
  const DynamicFormValidator();

  InstructionProfileValidation validate(List<Map<String, dynamic>> instructionProfile) {
    final accepted = <DynamicFieldDescriptor>[];
    final stripped = <String>[];
    final seenKeys = <String>{};

    for (final raw in instructionProfile) {
      final descriptor = DynamicFieldDescriptor.tryParse(raw);
      if (descriptor == null) {
        final marker = raw['key'] is String ? raw['key'] as String : (raw['type']?.toString() ?? 'unknown');
        stripped.add(marker);
        continue;
      }
      if (!seenKeys.add(descriptor.key)) {
        stripped.add(descriptor.key); // Duplicate keys are stripped.
        continue;
      }
      accepted.add(descriptor);
    }

    return InstructionProfileValidation(accepted: accepted, strippedKeys: stripped);
  }
}

/// Unified orchestration layout builder module.
///
/// Compiles a validated instruction profile into a clean, self-adjusting
/// workspace displaying only the requested input blocks. Layout follows
/// Material 3 with strict vertical padding increments, explicit placeholders
/// inside empty data cells, and uniform structural background containers.
class DynamicFormAssembler extends StatefulWidget {
  const DynamicFormAssembler({
    super.key,
    required this.instructionProfile,
    this.onChanged,
    this.onValidation,
    this.verticalSpacing = 16.0,
    this.validator = const DynamicFormValidator(),
  });

  /// Raw metadata instruction profile ingested from parent task state.
  final List<Map<String, dynamic>> instructionProfile;

  /// Emits the current map of field key → value whenever any field changes.
  final ValueChanged<Map<String, String>>? onChanged;

  /// Emits the structural validation result after compilation.
  final ValueChanged<InstructionProfileValidation>? onValidation;

  /// Strict vertical padding increment between responsive row items.
  final double verticalSpacing;

  final DynamicFormValidator validator;

  @override
  State<DynamicFormAssembler> createState() => _DynamicFormAssemblerState();
}

class _DynamicFormAssemblerState extends State<DynamicFormAssembler> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _values = {};
  late InstructionProfileValidation _validation;

  @override
  void initState() {
    super.initState();
    _compile(widget.instructionProfile);
  }

  @override
  void didUpdateWidget(covariant DynamicFormAssembler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.instructionProfile != widget.instructionProfile) {
      _compile(widget.instructionProfile);
    }
  }

  /// Self-chasing compile routine: terminates rendering of any descriptor
  /// whose instruction definition reveals a broken schema.
  void _compile(List<Map<String, dynamic>> profile) {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    _values.clear();

    _validation = widget.validator.validate(profile);
    for (final descriptor in _validation.accepted) {
      final initial = descriptor.initialValue ?? '';
      _controllers[descriptor.key] = TextEditingController(text: initial);
      _values[descriptor.key] = initial;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onValidation?.call(_validation);
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _emitChanged() {
    widget.onChanged?.call(Map<String, String>.unmodifiable(_values));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_validation.accepted.isEmpty) {
      return _UniformContainer(
        colorScheme: colorScheme,
        child: Text(
          'No fields requested by the instruction profile.',
          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < _validation.accepted.length; i++) ...[
          if (i > 0) SizedBox(height: widget.verticalSpacing),
          _UniformContainer(
            colorScheme: colorScheme,
            child: _buildField(context, _validation.accepted[i]),
          ),
        ],
      ],
    );
  }

  Widget _buildField(BuildContext context, DynamicFieldDescriptor descriptor) {
    final controller = _controllers[descriptor.key]!;
    final placeholder = descriptor.placeholder ?? 'Enter ${descriptor.label}';

    switch (descriptor.type) {
      case DynamicFieldType.dropdown:
        return DropdownButtonFormField<String>(
          initialValue: _values[descriptor.key]?.isNotEmpty == true ? _values[descriptor.key] : null,
          decoration: _inputDecoration(context, descriptor, placeholder),
          items: [
            for (final option in descriptor.options)
              DropdownMenuItem<String>(value: option, child: Text(option)),
          ],
          onChanged: (value) {
            _values[descriptor.key] = value ?? '';
            _emitChanged();
          },
        );
      case DynamicFieldType.checkbox:
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(descriptor.label),
          value: _values[descriptor.key] == 'true',
          onChanged: (checked) {
            setState(() => _values[descriptor.key] = (checked ?? false).toString());
            _emitChanged();
          },
        );
      case DynamicFieldType.multiline:
        return TextField(
          controller: controller,
          minLines: 3,
          maxLines: 6,
          decoration: _inputDecoration(context, descriptor, placeholder),
          onChanged: (value) {
            _values[descriptor.key] = value;
            _emitChanged();
          },
        );
      case DynamicFieldType.number:
        return _textInput(context, descriptor, controller, placeholder,
            keyboardType: TextInputType.number);
      case DynamicFieldType.email:
        return _textInput(context, descriptor, controller, placeholder,
            keyboardType: TextInputType.emailAddress);
      case DynamicFieldType.password:
        return _textInput(context, descriptor, controller, placeholder, obscure: true);
      case DynamicFieldType.date:
        return _textInput(context, descriptor, controller, placeholder,
            keyboardType: TextInputType.datetime);
      case DynamicFieldType.text:
        return _textInput(context, descriptor, controller, placeholder);
    }
  }

  Widget _textInput(
    BuildContext context,
    DynamicFieldDescriptor descriptor,
    TextEditingController controller,
    String placeholder, {
    TextInputType? keyboardType,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: _inputDecoration(context, descriptor, placeholder),
      onChanged: (value) {
        _values[descriptor.key] = value;
        _emitChanged();
      },
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context,
    DynamicFieldDescriptor descriptor,
    String placeholder,
  ) {
    return InputDecoration(
      labelText: descriptor.required ? '${descriptor.label} *' : descriptor.label,
      hintText: placeholder, // Explicit placeholder inside empty data cells.
      border: const OutlineInputBorder(),
      isDense: true,
    );
  }
}

/// Uniform structural background container mapping interface surfaces to a
/// single consistent visual container per Material 3 surface tokens.
class _UniformContainer extends StatelessWidget {
  const _UniformContainer({required this.colorScheme, required this.child});

  final ColorScheme colorScheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: child,
    );
  }
}
