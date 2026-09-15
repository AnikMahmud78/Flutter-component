// FIEVR-008-A17 — Predictive Word-of-Mouth Selection Dropdowns.
// Enforces validated autocomplete selection from master nursery directory; blocks free-text to secure attribution accuracy with Material 3 mobile-first UX.
import 'package:flutter/material.dart';

/// Validated acquisition origin entry from approved master directory.
@immutable
class AcquisitionOrigin {
  final String code;
  final String label;
  final String? category;
  const AcquisitionOrigin({required this.code, required this.label, this.category});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcquisitionOrigin && other.code == code;
  @override
  int get hashCode => code.hashCode;
  @override
  String toString() => label;
}

/// Reusable predictive selection field for onboarding / event subscription forms.
///
/// - Single-tap Material 3 autocomplete, no free-text allowed.
/// - Poka-Yoke: Form validation fails if channel parameter is null.
/// - Small-screen safe: constrained overlay, no heavy multi-select.
class PredictiveWomSelectionDropdown extends StatefulWidget {
  final List<AcquisitionOrigin> masterDirectory;
  final AcquisitionOrigin? initialSelection;
  final ValueChanged<AcquisitionOrigin>? onAttributionSelected;
  final VoidCallback? onOtherSelected;
  final String labelText;
  final String hintText;
  final bool enabled;
  final AutovalidateMode autovalidateMode;

  const PredictiveWomSelectionDropdown({
    super.key,
    required this.masterDirectory,
    this.initialSelection,
    this.onAttributionSelected,
    this.onOtherSelected,
    this.labelText = 'How did you hear about us?',
    this.hintText = 'Search nursery or referral source',
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<PredictiveWomSelectionDropdown> createState() =>
      _PredictiveWomSelectionDropdownState();
}

class _PredictiveWomSelectionDropdownState
    extends State<PredictiveWomSelectionDropdown> {
  AcquisitionOrigin? _selected;
  final GlobalKey<FormFieldState<AcquisitionOrigin?>> _fieldKey =
      GlobalKey<FormFieldState<AcquisitionOrigin?>>();

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelection;
  }

  @override
  void didUpdateWidget(PredictiveWomSelectionDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSelection != widget.initialSelection) {
      _selected = widget.initialSelection;
    }
  }

  Iterable<AcquisitionOrigin> _filter(TextEditingValue textValue) {
    final q = textValue.text.trim().toLowerCase();
    if (q.isEmpty) return widget.masterDirectory.take(8);
    return widget.masterDirectory.where((e) {
      return e.label.toLowerCase().contains(q) ||
          e.code.toLowerCase().contains(q) ||
          (e.category?.toLowerCase().contains(q) ?? false);
    }).take(8);
  }

  String? _validator(AcquisitionOrigin? value) {
    if (value == null) return 'Please select a validated source to continue';
    final valid = widget.masterDirectory.any((e) => e.code == value.code);
    if (!valid) return 'Free-text entries are not allowed. Pick from list.';
    return null;
  }

  void _handleSelected(AcquisitionOrigin selection, FormFieldState<AcquisitionOrigin?> field) {
    setState(() => _selected = selection);
    field.didChange(selection);
    widget.onAttributionSelected?.call(selection);
    if (selection.code.toUpperCase() == 'OTHER') {
      widget.onOtherSelected?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return FormField<AcquisitionOrigin?>(
      key: _fieldKey,
      initialValue: _selected,
      autovalidateMode: widget.autovalidateMode,
      validator: _validator,
      builder: (field) {
        final hasError = field.hasError;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Autocomplete<AcquisitionOrigin>(
              initialValue: TextEditingValue(text: _selected?.label ?? ''),
              displayStringForOption: (o) => o.label,
              optionsBuilder: _filter,
              onSelected: (s) => _handleSelected(s, field),
              fieldViewBuilder: (ctx, controller, focusNode, onSubmit) {
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  enabled: widget.enabled,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (_) => onSubmit(),
                  onChanged: (_) {
                    if (_selected != null && controller.text != _selected!.label) {
                      setState(() => _selected = null);
                      field.didChange(null);
                    }
                  },
                  onTapOutside: (_) => focusNode.unfocus(),
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    labelText: widget.labelText,
                    hintText: widget.hintText,
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: controller.text.isNotEmpty
                        ? IconButton(
                            tooltip: 'Clear',
                            icon: const Icon(Icons.clear_rounded),
                            onPressed: widget.enabled
                                ? () {
                                    controller.clear();
                                    setState(() => _selected = null);
                                    field.didChange(null);
                                  }
                                : null,
                          )
                        : const Icon(Icons.expand_more_rounded),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colorScheme.primary, width: 1.6),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colorScheme.error),
                    ),
                    errorText: hasError ? field.errorText : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                );
              },
              optionsViewBuilder: (ctx, onSel, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 3,
                    color: colorScheme.surfaceContainerLow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 240, maxWidth: 480),
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        shrinkWrap: true,
                        itemCount: options.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (c, i) {
                          final opt = options.elementAt(i);
                          final isSel = opt == _selected;
                          return ListTile(
                            dense: true,
                            leading: Icon(
                              opt.code.toUpperCase() == 'OTHER'
                                  ? Icons.more_horiz_rounded
                                  : Icons.storefront_outlined,
                              color: isSel ? colorScheme.primary : colorScheme.onSurfaceVariant,
                            ),
                            title: Text(opt.label, style: theme.textTheme.bodyMedium),
                            subtitle: opt.category != null
                                ? Text(opt.category!, style: theme.textTheme.bodySmall)
                                : null,
                            trailing: isSel ? Icon(Icons.check_rounded, color: colorScheme.primary) : null,
                            selected: isSel,
                            selectedTileColor: colorScheme.primaryContainer.withOpacity(0.35),
                            onTap: () => onSel(opt),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              'Validated origin code required • ${_selected?.code ?? 'none'}',
              style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        );
      },
    );
  }
}

/// Helper to emit self-chasing alert when OTHER exceeds 20% of conversions.
bool shouldAlertOtherThreshold({required int otherCount, required int totalCount}) {
  if (totalCount <= 0) return false;
  return (otherCount / totalCount) > 0.2;
}
