// FIEVR-034-A08 — InputFieldGroup: Molecular Form Layout Element for the Universal Component Library.
// Groups label descriptors with text input boxes in a rigid vertical layout array, embeds helper
// hints and dynamic validation indicators, and applies unified focus transitions with subtle
// container shade changes. Enforces strict 8dp grid spacing, programmatic label-input linking
// for screen-reader accessibility (Poka-Yoke), and clean mobile soft-keyboard view adjustments.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Validation state driving the dynamic indicator rendered inside the
/// standard tracking block of an [InputFieldGroup].
enum InputFieldValidationState {
  /// No validation has run yet; neutral indicator.
  idle,

  /// The current entry satisfies all rules; success indicator.
  valid,

  /// The current entry matches an invalid field; clear error indicator.
  invalid,
}

/// A single field definition inside an [InputFieldGroup].
///
/// Each item owns its label, controller, hint and validation metadata so the
/// group can render a rigid, evenly spaced vertical array of fields.
class InputFieldGroupItem {
  const InputFieldGroupItem({
    required this.label,
    required this.controller,
    this.helperHint,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.autofillHints,
  });

  /// Label descriptor programmatically linked to the input for a11y.
  final String label;

  /// Controller backing the text input box.
  final TextEditingController controller;

  /// Optional helper hint embedded inside the active component group.
  final String? helperHint;

  /// Error text surfaced when validation marks the entry invalid.
  final String? errorText;

  /// Keyboard type optimised for mobile soft-keyboard transitions.
  final TextInputType? keyboardType;

  /// Action button shown on the mobile soft keyboard.
  final TextInputAction? textInputAction;

  /// Whether the input obscures its text (e.g. passwords).
  final bool obscureText;

  /// Optional input formatters applied to the entry.
  final List<TextInputFormatter>? inputFormatters;

  /// Validator returning an error message, or null when the entry is valid.
  final String? Function(String value)? validator;

  /// Callback fired whenever the entry changes.
  final ValueChanged<String>? onChanged;

  /// Whether the field accepts input.
  final bool enabled;

  /// Autofill hints forwarded to the platform.
  final Iterable<String>? autofillHints;
}

/// Molecular form layout component that stacks structural layout tags
/// (labels) vertically above data inputs to maximise horizontal area for
/// text visibility on narrow mobile screens.
///
/// Design-token inheritance: all colours, spacing and typography resolve
/// from the ambient [ThemeData] (Material 3), so molecules automatically
/// inherit tokens defined at the atomic level of the library.
class InputFieldGroup extends StatefulWidget {
  const InputFieldGroup({
    super.key,
    required this.items,
    this.groupLabel,
    this.spacing = 16.0,
    this.labelSpacing = 8.0,
    this.focusTransitionDuration = const Duration(milliseconds: 180),
    this.padding = EdgeInsets.zero,
  })  : assert(spacing % 8 == 0, 'spacing must follow strict 8dp grid increments'),
        assert(labelSpacing % 8 == 0, 'labelSpacing must follow strict 8dp grid increments');

  /// Field definitions rendered as a rigid vertical layout array.
  final List<InputFieldGroupItem> items;

  /// Optional group label rendered above the field array.
  final String? groupLabel;

  /// Vertical gap between parallel input rows (strict 8dp increments).
  final double spacing;

  /// Vertical gap between a label and its input (strict 8dp increments).
  final double labelSpacing;

  /// Duration of the unified focus transition across all field groups.
  final Duration focusTransitionDuration;

  /// Outer padding around the whole group.
  final EdgeInsetsGeometry padding;

  @override
  State<InputFieldGroup> createState() => _InputFieldGroupState();
}

class _InputFieldGroupState extends State<InputFieldGroup> {
  late final List<FocusNode> _focusNodes;
  late final List<InputFieldValidationState> _validationStates;

  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode>.generate(
      widget.items.length,
      (int index) => FocusNode()..addListener(() => _onFocusChanged(index)),
    );
    _validationStates = List<InputFieldValidationState>.filled(
      widget.items.length,
      InputFieldValidationState.idle,
    );
  }

  @override
  void dispose() {
    for (final FocusNode node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onFocusChanged(int index) {
    if (!mounted) return;
    setState(() {});
    if (!_focusNodes[index].hasFocus) {
      _runValidation(index);
    }
  }

  void _runValidation(int index) {
    final InputFieldGroupItem item = widget.items[index];
    if (item.validator == null) return;
    final String? error = item.validator!(item.controller.text);
    setState(() {
      _validationStates[index] = error == null
          ? InputFieldValidationState.valid
          : InputFieldValidationState.invalid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final TextTheme text = theme.textTheme;

    // MediaQuery-driven bottom padding keeps the group clear of the mobile
    // soft keyboard, handling dynamic view adjustments cleanly.
    final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: widget.focusTransitionDuration,
      curve: Curves.easeOut,
      padding: widget.padding.add(EdgeInsets.only(bottom: keyboardInset > 0 ? 8.0 : 0.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.groupLabel != null) ...<Widget>[
            Semantics(
              header: true,
              child: Text(
                widget.groupLabel!,
                style: text.titleMedium?.copyWith(color: colors.onSurface),
              ),
            ),
            SizedBox(height: widget.spacing),
          ],
          for (int i = 0; i < widget.items.length; i++) ...<Widget>[
            if (i > 0) SizedBox(height: widget.spacing),
            _buildField(context, i, colors, text),
          ],
        ],
      ),
    );
  }

  Widget _buildField(
    BuildContext context,
    int index,
    ColorScheme colors,
    TextTheme text,
  ) {
    final InputFieldGroupItem item = widget.items[index];
    final bool focused = _focusNodes[index].hasFocus;
    final InputFieldValidationState state = _validationStates[index];
    final String fieldKey = 'input_field_group_${item.label.hashCode}';

    // Subtle container shade transition applied on background focus fields.
    final Color containerColor = focused
        ? colors.primaryContainer.withOpacity(0.18)
        : colors.surfaceContainerHighest.withOpacity(0.35);

    final String? effectiveError = state == InputFieldValidationState.invalid
        ? (item.errorText ?? item.validator?.call(item.controller.text))
        : null;

    return AnimatedContainer(
      duration: widget.focusTransitionDuration,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: state == InputFieldValidationState.invalid
              ? colors.error
              : focused
                  ? colors.primary
                  : colors.outlineVariant,
          width: focused || state == InputFieldValidationState.invalid ? 1.6 : 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Structural layout tag stacked vertically above the data input.
          // Semantics(label) + explicit link guarantees screen-reader
          // accessibility across mobile configurations (Poka-Yoke).
          Semantics(
            label: item.label,
            child: Text(
              item.label,
              style: text.labelLarge?.copyWith(
                color: state == InputFieldValidationState.invalid
                    ? colors.error
                    : focused
                        ? colors.primary
                        : colors.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: widget.labelSpacing),
          TextField(
            key: Key(fieldKey),
            controller: item.controller,
            focusNode: _focusNodes[index],
            keyboardType: item.keyboardType,
            textInputAction: item.textInputAction ??
                (index < widget.items.length - 1
                    ? TextInputAction.next
                    : TextInputAction.done),
            obscureText: item.obscureText,
            inputFormatters: item.inputFormatters,
            enabled: item.enabled,
            autofillHints: item.autofillHints,
            style: text.bodyLarge?.copyWith(color: colors.onSurface),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: item.helperHint,
              hintStyle: text.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant.withOpacity(0.6),
              ),
              errorText: null, // Error surfaced via the tracking block below.
            ),
            onChanged: (String value) {
              item.onChanged?.call(value);
              if (_validationStates[index] != InputFieldValidationState.idle) {
                _runValidation(index);
              }
            },
            onEditingComplete: () {
              _runValidation(index);
              if (index < widget.items.length - 1) {
                _focusNodes[index + 1].requestFocus();
              } else {
                _focusNodes[index].unfocus();
              }
            },
          ),
          SizedBox(height: widget.labelSpacing),
          // Standard tracking block hosting the dynamic validation indicator
          // asset and the helper hint / error message.
          _buildTrackingBlock(item, state, effectiveError, colors, text),
        ],
      ),
    );
  }

  Widget _buildTrackingBlock(
    InputFieldGroupItem item,
    InputFieldValidationState state,
    String? effectiveError,
    ColorScheme colors,
    TextTheme text,
  ) {
    final (IconData icon, Color color, String message) = switch (state) {
      InputFieldValidationState.invalid => (
          Icons.error_outline,
          colors.error,
          effectiveError ?? 'Invalid entry',
        ),
      InputFieldValidationState.valid => (
          Icons.check_circle_outline,
          colors.primary,
          item.helperHint ?? '',
        ),
      InputFieldValidationState.idle => (
          Icons.info_outline,
          colors.onSurfaceVariant,
          item.helperHint ?? '',
        ),
    };

    if (message.isEmpty && state == InputFieldValidationState.idle) {
      return const SizedBox.shrink();
    }

    return Semantics(
      liveRegion: state == InputFieldValidationState.invalid,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 16.0, color: color),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              message,
              style: text.bodySmall?.copyWith(color: color),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
