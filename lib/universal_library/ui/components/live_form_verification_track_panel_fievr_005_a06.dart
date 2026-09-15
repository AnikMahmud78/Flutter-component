// FIEVR-005-A06 — Live Form Verification Track Panel & Dynamic Completeness Checklist.
// Calculates completion metrics instantly on input changes, swaps warning flags to success checks, updates master progress %, and gates submit until 100%.
import 'package:flutter/material.dart';

/// Definition for a single trackable field in the completeness checklist.
/// [isOptional] fields are excluded from the 100% gate unless [includeOptionalWhenFilled] is true.
@immutable
class ChecklistFieldDefinition {
  const ChecklistFieldDefinition({
    required this.id,
    required this.label,
    required this.instructionNote,
    this.isOptional = false,
    this.validator,
  });

  final String id;
  final String label;
  final String instructionNote;
  final bool isOptional;
  final bool Function(String value)? validator;

  bool isSatisfied(String value) {
    final v = value.trim();
    if (isOptional && v.isEmpty) return true;
    if (v.isEmpty) return false;
    return validator?.call(v) ?? true;
  }
}

/// Snapshot of completeness calculation.
@immutable
class FormCompletenessSnapshot {
  const FormCompletenessSnapshot({
    required this.perFieldPass,
    required this.completedRequired,
    required this.totalRequired,
    required this.percent,
    required this.isComplete,
  });

  final Map<String, bool> perFieldPass;
  final int completedRequired;
  final int totalRequired;
  final double percent;
  final bool isComplete;

  static FormCompletenessSnapshot calculate({
    required List<ChecklistFieldDefinition> definitions,
    required Map<String, String> values,
  }) {
    final requiredDefs =
        definitions.where((d) => !d.isOptional).toList();
    final perField = <String, bool>{};
    for (final d in definitions) {
      perField[d.id] = d.isSatisfied(values[d.id] ?? '');
    }
    int done = 0;
    for (final d in requiredDefs) {
      if (perField[d.id] == true) done++;
    }
    final total = requiredDefs.length;
    final pct = total == 0 ? 1.0 : done / total;
    return FormCompletenessSnapshot(
      perFieldPass: perField,
      completedRequired: done,
      totalRequired: total,
      percent: pct.clamp(0.0, 1.0),
      isComplete: total == 0 || done == total,
    );
  }
}

/// Live Form Verification Track Panel — Master Field Checklist Box.
///
/// Position directly above mobile form layouts. Listens to input value
/// changes via [controllers] and focus changes via [focusNodes], updates
/// progress instantly, and keeps submit disabled until 100% (Poka-Yoke).
class LiveFormVerificationTrackPanelFievr005A06 extends StatefulWidget {
  const LiveFormVerificationTrackPanelFievr005A06({
    super.key,
    required this.definitions,
    required this.controllers,
    this.focusNodes,
    this.title = 'Form completeness',
    this.submitLabel = 'Submit',
    this.onSubmit,
    this.onCompletenessChanged,
    this.compact = false,
  });

  final List<ChecklistFieldDefinition> definitions;
  final Map<String, TextEditingController> controllers;
  final Map<String, FocusNode>? focusNodes;
  final String title;
  final String submitLabel;
  final VoidCallback? onSubmit;
  final ValueChanged<FormCompletenessSnapshot>? onCompletenessChanged;
  final bool compact;

  @override
  State<LiveFormVerificationTrackPanelFievr005A06> createState() =>
      _LiveFormVerificationTrackPanelState();
}

class _LiveFormVerificationTrackPanelState
    extends State<LiveFormVerificationTrackPanelFievr005A06> {
  late FormCompletenessSnapshot _snapshot;
  final Set<String> _touched = {};

  @override
  void initState() {
    super.initState();
    _snapshot = _compute();
    for (final entry in widget.controllers.entries) {
      entry.value.addListener(_onInputChanged);
    }
    widget.focusNodes?.forEach((id, node) {
      node.addListener(() => _onFocusChanged(id, node.hasFocus));
    });
  }

  @override
  void didUpdateWidget(
      covariant LiveFormVerificationTrackPanelFievr005A06 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controllers != widget.controllers) {
      for (final c in oldWidget.controllers.values) {
        c.removeListener(_onInputChanged);
      }
      for (final c in widget.controllers.values) {
        c.addListener(_onInputChanged);
      }
      _refresh();
    }
  }

  @override
  void dispose() {
    for (final c in widget.controllers.values) {
      c.removeListener(_onInputChanged);
    }
    super.dispose();
  }

  Map<String, String> _currentValues() => {
        for (final d in widget.definitions)
          d.id: widget.controllers[d.id]?.text ?? '',
      };

  FormCompletenessSnapshot _compute() {
    return FormCompletenessSnapshot.calculate(
      definitions: widget.definitions,
      values: _currentValues(),
    );
  }

  void _onInputChanged() => _refresh();

  void _onFocusChanged(String id, bool hasFocus) {
    if (!hasFocus && !_touched.contains(id)) {
      setState(() => _touched.add(id));
    } else if (hasFocus) {
      // Standard focus state change read — rebuild to clear stale alert styling if needed.
      if (mounted) setState(() {});
    }
  }

  void _refresh() {
    final next = _compute();
    if (!mounted) return;
    setState(() => _snapshot = next);
    widget.onCompletenessChanged?.call(next);
  }

  void markAllTouched() => setState(() {
        _touched.addAll(widget.definitions.map((d) => d.id));
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final pct = _snapshot.percent;
    final pctLabel = '${(pct * 100).round()}%';
    final isComplete = _snapshot.isComplete;

    final progressColor = isComplete ? cs.primary : cs.tertiary;
    final badgeBg = isComplete ? cs.primaryContainer : cs.errorContainer;
    final badgeFg = isComplete ? cs.onPrimaryContainer : cs.onErrorContainer;

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _StateBadge(
                  passed: isComplete,
                  background: badgeBg,
                  foreground: badgeFg,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: theme.textTheme.titleSmall),
                      const SizedBox(height: 2),
                      Text(
                        isComplete
                            ? 'All required fields complete — ready to submit.'
                            : '${_snapshot.completedRequired} of ${_snapshot.totalRequired} required fields complete',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    pctLabel,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Semantics(
              label: 'Form progress $pctLabel',
              value: pctLabel,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: pct,
                  minHeight: 8,
                  backgroundColor: cs.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
            ),
            if (!widget.compact) const SizedBox(height: 12),
            if (!widget.compact)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.definitions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final def = widget.definitions[index];
                  final passed = _snapshot.perFieldPass[def.id] ?? false;
                  final showAlert =
                      !passed && (_touched.contains(def.id) || pct == 1.0 ? true : _touched.contains(def.id));
                  return _ChecklistRow(
                    definition: def,
                    passed: passed,
                    showInstruction: showAlert || !passed,
                    onTap: () => widget.focusNodes?[def.id]?.requestFocus(),
                  );
                },
              ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: isComplete ? widget.onSubmit : () => markAllTouched(),
              icon: Icon(isComplete ? Icons.check_circle : Icons.lock_outline),
              label: Text(isComplete
                  ? widget.submitLabel
                  : '${widget.submitLabel} • $pctLabel'),
            ),
            if (!isComplete)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Submit stays disabled until the checklist hits 100%.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StateBadge extends StatelessWidget {
  const _StateBadge({
    required this.passed,
    required this.background,
    required this.foreground,
  });

  final bool passed;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(
        passed ? Icons.check : Icons.priority_high,
        color: foreground,
        size: 20,
        semanticLabel: passed ? 'Complete' : 'Attention needed',
      ),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({
    required this.definition,
    required this.passed,
    required this.showInstruction,
    this.onTap,
  });

  final ChecklistFieldDefinition definition;
  final bool passed;
  final bool showInstruction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final icon = passed ? Icons.check_circle : Icons.error_outline;
    final iconColor = passed ? cs.primary : cs.error;
    final borderColor = passed ? cs.outlineVariant : cs.error;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: passed ? cs.outlineVariant : borderColor,
            width: passed ? 1 : 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(definition.label,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: passed
                              ? cs.primaryContainer
                              : cs.errorContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          passed
                              ? (definition.isOptional ? 'Optional • OK' : 'Done')
                              : (definition.isOptional ? 'Optional' : 'Required'),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: passed
                                ? cs.onPrimaryContainer
                                : cs.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (showInstruction) ...[
                    const SizedBox(height: 4),
                    Text(
                      definition.instructionNote,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: passed
                            ? cs.onSurfaceVariant
                            : cs.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
