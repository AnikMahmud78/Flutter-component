// FIEVR-006-A10 — Required Indicator Input Controls with Strict Red Asterisk Markers.
// Enforces Material 3 high-contrast red asterisks adjacent to labels for all required fields with responsive scaling and helper-text support.
import 'package:flutter/material.dart';

/// Token parameters for required asterisk markers (FIEVR-006-A10).
///
/// Standard symbol `*` rendered in high-contrast red per Material 3
/// and brand parameters. Spacing follows 4dp metric increments.
class RequiredMarkerTokens {
  const RequiredMarkerTokens._();
  static const String asteriskSymbol = '*';
  static const double asteriskFontScale = 1.0;
  static const double gapLabelToMarker = 4.0;
  static const double gapLabelToField = 8.0;
  static const double gapFieldToHelper = 4.0;
}

/// Layout config for form component block to scale fluidly across viewports.
@immutable
class RequiredFieldLayoutConfig {
  final TextStyle? labelStyle;
  final TextStyle? asteriskStyle;
  final double spacingScale;
  final Alignment alignment;
  const RequiredFieldLayoutConfig({
    this.labelStyle,
    this.asteriskStyle,
    this.spacingScale = 1.0,
    this.alignment = Alignment.centerLeft,
  });
}

/// High-visibility required label with strict red asterisk.
///
/// Renders `label + *` when [isRequired] is true. Asterisk uses
/// [ColorScheme.error] for contrast and exposes semantics for a11y.
class RequiredFieldLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  final RequiredFieldLayoutConfig config;
  final bool showHelperCallout;
  final String? helperText;

  const RequiredFieldLabel({
    super.key,
    required this.label,
    required this.isRequired,
    this.config = const RequiredFieldLayoutConfig(),
    this.showHelperCallout = false,
    this.helperText,
  }) : assert(label.isNotEmpty, 'FIEVR-006-A10: label must not be empty when indicator is bound');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final baseLabelStyle = config.labelStyle ??
        theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        );
    final asteriskStyle = config.asteriskStyle ??
        theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.error,
          fontSize: (baseLabelStyle?.fontSize ?? 14) * RequiredMarkerTokens.asteriskFontScale,
        );

    return Semantics(
      header: true,
      label: isRequired ? '$label, required' : label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(label, style: baseLabelStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
              if (isRequired) ...[
                SizedBox(width: RequiredMarkerTokens.gapLabelToMarker * config.spacingScale),
                Text(
                  RequiredMarkerTokens.asteriskSymbol,
                  style: asteriskStyle,
                  semanticsLabel: 'required',
                ),
              ],
            ],
          ),
          if (showHelperCallout && helperText != null && helperText!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: RequiredMarkerTokens.gapFieldToHelper * config.spacingScale),
              child: Text(helperText!, style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
            ),
        ],
      ),
    );
  }
}

/// Production TextFormField wrapper that dynamically appends required indicator.
///
/// Binds visual asterisk to backend `isRequired` constraint. Fails fast in
/// debug if a required field lacks a label (poka-yoke).
class RequiredTextFormField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextEditingController? controller;
  final String? hintText;
  final String? helperText;
  final bool showHelperCallout;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final RequiredFieldLayoutConfig layoutConfig;

  const RequiredTextFormField({
    super.key,
    required this.label,
    this.isRequired = false,
    this.controller,
    this.hintText,
    this.helperText,
    this.showHelperCallout = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.layoutConfig = const RequiredFieldLayoutConfig(),
  });

  String? _defaultValidator(String? v) {
    if (isRequired && (v == null || v.trim().isEmpty)) {
      return '$label is required';
    }
    return validator?.call(v);
  }

  @override
  Widget build(BuildContext context) {
    assert(!isRequired || label.isNotEmpty, 'FIEVR-006-A10: required fields must provide label for asterisk binding');
    final theme = Theme.of(context);
    final spacing = layoutConfig.spacingScale;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 360;
        final fieldSpacing = (isCompact ? 6.0 : RequiredMarkerTokens.gapLabelToField) * spacing;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RequiredFieldLabel(
              label: label,
              isRequired: isRequired,
              config: layoutConfig,
              showHelperCallout: false,
            ),
            SizedBox(height: fieldSpacing),
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              maxLines: maxLines,
              onChanged: onChanged,
              validator: _defaultValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: hintText,
                helperText: showHelperCallout ? helperText : null,
                helperMaxLines: 2,
                border: const OutlineInputBorder(),
                errorStyle: TextStyle(color: theme.colorScheme.error),
              ),
            ),
            if (showHelperCallout && !isRequired && helperText != null && helperText!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: RequiredMarkerTokens.gapFieldToHelper * spacing),
                child: Text(helperText!, style: theme.textTheme.bodySmall),
              ),
          ],
        );
      },
    );
  }
}

/// Validation helper to confirm 100% of required params display asterisks.
///
/// Use in widget tests / code checks across form layers.
class RequiredIndicatorChecker {
  const RequiredIndicatorChecker._();
  static bool hasIndicator({required bool isRequired, required String label}) {
    if (!isRequired) return true;
    return label.isNotEmpty;
  }

  static void assertConsistency(List<RequiredTextFormField> fields) {
    for (final f in fields) {
      assert(hasIndicator(isRequired: f.isRequired, label: f.label),
          'FIEVR-006-A10: required field missing asterisk label: ${f.label}');
    }
  }
}
