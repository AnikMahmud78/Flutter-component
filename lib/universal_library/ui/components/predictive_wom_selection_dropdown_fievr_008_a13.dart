// FIEVR-008-A13 — Predictive Word-of-Mouth Selection Dropdown.
// Enforces validated single-select autocomplete from master nursery directory, blocks free-text and maps choice to attribution matrix.
import 'package:flutter/material.dart';

/// Master directory entry for a target nursery / acquisition source.
@immutable
class WomAcquisitionSource {
  const WomAcquisitionSource({
    required this.id,
    required this.displayName,
    required this.originCode,
    required this.sourceLogRef,
  });

  final String id;
  final String displayName;
  final String originCode;
  final String sourceLogRef;

  @override
  String toString() => displayName;
}

/// Attribution event emitted when a validated choice maps to the matrix.
@immutable
class WomAttributionEvent {
  const WomAttributionEvent({
    required this.originCode,
    required this.displayName,
    required this.sourceLogRef,
    required this.timestamp,
    required this.sessionId,
  });

  final String originCode;
  final String displayName;
  final String sourceLogRef;
  final DateTime timestamp;
  final String sessionId;
}

/// Enforces predictive word-of-mouth selection with no free-text.
///
/// - Single-tap Material 3 autocomplete, small-screen safe overlay.
/// - Poka-Yoke: continuation stays frozen while channel is null.
/// - Tracing: [verifyMapsToSourceLogs] ensures selection maps to source logs.
class PredictiveWomSelectionDropdownFievr008A13 extends StatefulWidget {
  const PredictiveWomSelectionDropdownFievr008A13({
    super.key,
    required this.masterDirectory,
    required this.sessionId,
    this.initialValue,
    this.labelText = 'How did you hear about us?',
    this.placeholder = 'Search nursery / referrer',
    this.enabled = true,
    this.onAttributionMapped,
    this.onOtherThresholdExceeded,
    this.onChanged,
  });

  final List<WomAcquisitionSource> masterDirectory;
  final String sessionId;
  final WomAcquisitionSource? initialValue;
  final String labelText;
  final String placeholder;
  final bool enabled;
  final ValueChanged<WomAttributionEvent>? onAttributionMapped;
  final VoidCallback? onOtherThresholdExceeded;
  final ValueChanged<WomAcquisitionSource?>? onChanged;

  /// Self-chasing rule: alert if "Other" exceeds 20% of conversions.
  static bool shouldAlertForOther({required int otherCount, required int totalCount}) {
    if (totalCount <= 0) return false;
    return (otherCount / totalCount) > 0.20;
  }

  @override
  State<PredictiveWomSelectionDropdownFievr008A13> createState() => _PredictiveWomSelectionDropdownState();
}

class _PredictiveWomSelectionDropdownState extends State<PredictiveWomSelectionDropdownFievr008A13> {
  WomAcquisitionSource? _selected;
  String? _errorText;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  bool get isValid => _selected != null && _errorText == null;
  String? get selectedOriginCode => _selected?.originCode;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
    _controller = TextEditingController(text: widget.initialValue?.displayName ?? '');
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Iterable<WomAcquisitionSource> _filterOptions(TextEditingValue textValue) {
    final q = textValue.text.trim().toLowerCase();
    if (q.isEmpty) return widget.masterDirectory;
    return widget.masterDirectory.where((s) =>
        s.displayName.toLowerCase().contains(q) || s.originCode.toLowerCase().contains(q));
  }

  void _commitSelection(WomAcquisitionSource selection) {
    setState(() {
      _selected = selection;
      _errorText = null;
    });
    widget.onChanged?.call(selection);
    widget.onAttributionMapped?.call(WomAttributionEvent(
      originCode: selection.originCode,
      displayName: selection.displayName,
      sourceLogRef: selection.sourceLogRef,
      timestamp: DateTime.now().toUtc(),
      sessionId: widget.sessionId,
    ));
    if (selection.displayName.toLowerCase() == 'other') {
      widget.onOtherThresholdExceeded?.call();
    }
  }

  /// Blocks free-text: text must exactly match a directory entry.
  void _enforceNoFreeText(String text) {
    if (text.trim().isEmpty) {
      setState(() {
        _selected = null;
        _errorText = 'Channel parameter required — choose a validated source.';
      });
      widget.onChanged?.call(null);
      return;
    }
    final match = widget.masterDirectory.where((e) => e.displayName == text.trim());
    if (match.isEmpty) {
      setState(() {
        _selected = null;
        _errorText = 'Free-text not allowed — pick from predictive list.';
      });
      widget.onChanged?.call(null);
    }
  }

  /// Tracing test hook: verifies selection maps back to source logs.
  bool verifyMapsToSourceLogs() {
    final s = _selected;
    if (s == null) return false;
    if (s.originCode.isEmpty || s.sourceLogRef.isEmpty) return false;
    return widget.masterDirectory.any((e) => e.originCode == s.originCode && e.sourceLogRef == s.sourceLogRef);
  }

  /// Poka-Yoke gate for onboarding continuation buttons.
  bool validateForContinuation() {
    if (_selected == null) {
      setState(() => _errorText = 'Select a validated source to continue.');
      return false;
    }
    if (!verifyMapsToSourceLogs()) {
      setState(() => _errorText = 'Selection failed trace check — re-select.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Autocomplete<WomAcquisitionSource>(
          displayStringForOption: (o) => o.displayName,
          optionsBuilder: _filterOptions,
          initialValue: TextEditingValue(text: _controller.text),
          onSelected: _commitSelection,
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(12),
                color: colorScheme.surfaceContainerHigh,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 280, maxWidth: 480),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final opt = options.elementAt(index);
                      final isOther = opt.displayName.toLowerCase() == 'other';
                      return ListTile(
                        dense: true,
                        leading: Icon(isOther ? Icons.more_horiz : Icons.store_outlined, size: 20),
                        title: Text(opt.displayName, style: theme.textTheme.bodyMedium),
                        subtitle: Text(opt.originCode, style: theme.textTheme.labelSmall),
                        onTap: () => onSelected(opt),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          fieldViewBuilder: (context, textCtrl, focusNode, onSubmitted) {
            // Mirror external controller for programmatic tracing tests.
            if (textCtrl.text != _controller.text && !_focusNode.hasFocus) {
              textCtrl.text = _controller.text;
            }
            return TextFormField(
              controller: textCtrl,
              focusNode: focusNode,
              enabled: widget.enabled,
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.placeholder,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: textCtrl.text.isNotEmpty
                    ? IconButton(icon: const Icon(Icons.clear), onPressed: widget.enabled ? () { textCtrl.clear(); _enforceNoFreeText(''); } : null)
                    : const Icon(Icons.arrow_drop_down),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                errorText: _errorText,
              ),
              onChanged: (_) {
                // Invalidate stale selection on edit to block free-text bypass.
                if (_selected != null && textCtrl.text != _selected!.displayName) {
                  setState(() => _selected = null);
                }
              },
              onFieldSubmitted: (v) => _enforceNoFreeText(v),
              onEditingComplete: () => _enforceNoFreeText(textCtrl.text),
            );
          },
        ),
        const SizedBox(height: 4),
        Text(
          _selected == null ? 'Tap to search — typing alone will not validate.' : 'Origin: ${_selected!.originCode} • traced',
          style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
