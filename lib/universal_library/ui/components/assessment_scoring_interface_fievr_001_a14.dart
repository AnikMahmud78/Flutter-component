// FIEVR-001-A14 — Assessment Scoring Interface Integration with MD3 tokens.
// Applies MD3 colors, typography, spacing to structured numeric scorecard with frozen-submit Poka-Yoke and responsive layout.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// MD3 design-token source for FIEVR-001-A14.
/// Centralizes colors, typography, spacing per SETUP-02 spec.
class Fievr001A14Tokens {
  Fievr001A14Tokens._();
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 12.0;
  static const double spacingLg = 16.0;
  static const double spacingXl = 24.0;
  static const double spacingXxl = 32.0;
  static const double cardRadius = 16.0;
  static const double bannerRadius = 12.0;
  static const double fieldRadius = 12.0;
  static const double maxContentWidth = 720.0;
}

/// Single grading rubric dimension.
class ScoringCriterionA14 {
  const ScoringCriterionA14({
    required this.id,
    required this.label,
    required this.description,
    this.maxScore = 10,
    this.minScore = 0,
  });
  final String id;
  final String label;
  final String description;
  final int maxScore;
  final int minScore;
}

/// Default core skill dimensions per Decision: Finalization of targeted grading rubrics.
const List<ScoringCriterionA14> kDefaultCriteriaA14 = [
  ScoringCriterionA14(id: 'clinical', label: 'Clinical Capability', description: 'Verified practitioner skill evidence'),
  ScoringCriterionA14(id: 'communication', label: 'Communication', description: 'Clarity and empathy in applicant responses'),
  ScoringCriterionA14(id: 'ethics', label: 'Ethics & Safety', description: 'Compliance with quality curation standards'),
  ScoringCriterionA14(id: 'documentation', label: 'Documentation', description: 'Completeness of assessment rows'),
];

/// Callback fired on save — links entry saves to downstream index update events (HC-API-0033).
typedef ScoringSaveCallback = Future<void> Function(Map<String, int> scores);

/// Integrated assessment scoring forms connected to backend tracking layers.
///
/// Features:
/// - MD3 colors/typography/spacing only (no hardcoded styles).
/// - Numeric-only inputs (Poka-Yoke: submission frozen until all boxes filled).
/// - Visibility rule: profile discoverability locked until all criteria pass.
/// - High-contrast warning banner + Material alert + 1-tap reactivation.
/// - Responsive: single column on narrow, two columns on wide.
class AssessmentScoringInterfaceA14 extends StatefulWidget {
  const AssessmentScoringInterfaceA14({
    super.key,
    this.criteria = kDefaultCriteriaA14,
    this.passThreshold = 7,
    this.isOnline = true,
    this.isHiddenProfile = false,
    this.onSave,
    this.onReactivated,
  });
  final List<ScoringCriterionA14> criteria;
  final int passThreshold;
  final bool isOnline;
  final bool isHiddenProfile;
  final ScoringSaveCallback? onSave;
  final VoidCallback? onReactivated;

  @override
  State<AssessmentScoringInterfaceA14> createState() => _AssessmentScoringInterfaceA14State();
}

class _AssessmentScoringInterfaceA14State extends State<AssessmentScoringInterfaceA14> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> _controllers;
  bool _saving = false;
  String? _errorTicket;

  @override
  void initState() {
    super.initState();
    _controllers = {for (final c in widget.criteria) c.id: TextEditingController()};
    for (final c in _controllers.values) {
      c.addListener(_onChanged);
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  bool get _allFilled {
    for (final entry in _controllers.entries) {
      final v = entry.value.text.trim();
      if (v.isEmpty) return false;
      if (int.tryParse(v) == null) return false;
    }
    return true;
  }

  Map<String, int> get _currentScores {
    return {for (final e in _controllers.entries) e.key: int.tryParse(e.value.text.trim()) ?? -1};
  }

  bool get _allPass {
    if (!_allFilled) return false;
    return _currentScores.values.every((s) => s >= widget.passThreshold);
  }

  double get _average {
    if (!_allFilled) return 0;
    final vals = _currentScores.values.toList();
    return vals.reduce((a, b) => a + b) / vals.length;
  }

  Future<void> _handleSave() async {
    FocusScope.of(context).unfocus();
    setState(() => _errorTicket = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_allFilled) return;
    setState(() => _saving = true);
    try {
      // Real-time logging hook for verification actions (GCP/BigQuery alignment).
      debugPrint('[FIEVR-001-A14] save scores=${_currentScores} ts=${DateTime.now().toIso8601String()}');
      if (widget.onSave != null) {
        await widget.onSave!(_currentScores);
      } else {
        await Future<void>.delayed(const Duration(milliseconds: 600));
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Scores saved • avg ${_average.toStringAsFixed(1)} • profile ${_allPass ? 'discoverable' : 'locked'}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      // Self-chasing: freeze channel + urgent correction ticket.
      setState(() => _errorTicket = 'CORR-${DateTime.now().millisecondsSinceEpoch}');
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: Icon(Icons.error_outline, color: Theme.of(ctx).colorScheme.error),
          title: const Text('Score exception — channel frozen'),
          content: Text('Save failed ($e). Ticket $_errorTicket created. Correct data and retry.'),
          actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('OK'))],
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String? _validator(ScoringCriterionA14 c, String? v) {
    final t = (v ?? '').trim();
    if (t.isEmpty) return 'Required';
    final n = int.tryParse(t);
    if (n == null) return 'Numbers only';
    if (n < c.minScore || n > c.maxScore) return '${c.minScore}–${c.maxScore} only';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final text = theme.textTheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Fievr001A14Tokens.maxContentWidth),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeaderCard(text: text, colors: colors, average: _average, allPass: _allPass, allFilled: _allFilled),
              const SizedBox(height: Fievr001A14Tokens.spacingLg),
              if (!widget.isOnline || widget.isHiddenProfile) ...[
                _OfflineWarningBanner(
                  onReactivate: widget.isOnline
                      ? () {
                          widget.onReactivated?.call();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reactivation requested'), behavior: SnackBarBehavior.floating));
                        }
                      : null,
                ),
                const SizedBox(height: Fievr001A14Tokens.spacingLg),
              ],
              if (_errorTicket != null) ...[
                MaterialBanner(
                  content: Text('Processing frozen • ticket $_errorTicket', style: text.bodyMedium),
                  leading: Icon(Icons.pause_circle_outline, color: colors.error),
                  backgroundColor: colors.errorContainer,
                  actions: [TextButton(onPressed: () => setState(() => _errorTicket = null), child: const Text('DISMISS'))],
                ),
                const SizedBox(height: Fievr001A14Tokens.spacingLg),
              ],
              LayoutBuilder(
                builder: (ctx, constraints) {
                  final wide = constraints.maxWidth >= 560;
                  final fields = widget.criteria.map((c) => _ScoreField(
                        criterion: c,
                        controller: _controllers[c.id]!,
                        validator: (v) => _validator(c, v),
                      )).toList();
                  if (wide) {
                    return GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: Fievr001A14Tokens.spacingLg,
                      crossAxisSpacing: Fievr001A14Tokens.spacingLg,
                      childAspectRatio: 1.55,
                      children: fields,
                    );
                  }
                  return Column(children: [for (final f in fields) Padding(padding: const EdgeInsets.only(bottom: Fievr001A14Tokens.spacingLg), child: f)]);
                },
              ),
              const SizedBox(height: Fievr001A14Tokens.spacingSm),
              _StatusRow(allPass: _allPass, allFilled: _allFilled, threshold: widget.passThreshold),
              const SizedBox(height: Fievr001A14Tokens.spacingLg),
              // Poka-Yoke: physically frozen until every box has active parameter.
              FilledButton.icon(
                onPressed: (_allFilled && !_saving && _errorTicket == null) ? _handleSave : null,
                icon: _saving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.save_outlined),
                label: Text(_saving ? 'Saving to index...' : 'Save assessment & update index'),
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              ),
              const SizedBox(height: Fievr001A14Tokens.spacingSm),
              Text(
                _allFilled ? (_allPass ? 'All criteria pass — profile discoverable.' : 'Saved scores will keep profile locked until all passes.') : 'Enter a number in every scoring box to unlock submit.',
                style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.text, required this.colors, required this.average, required this.allPass, required this.allFilled});
  final TextTheme text;
  final ColorScheme colors;
  final double average;
  final bool allPass;
  final bool allFilled;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colors.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Fievr001A14Tokens.cardRadius), side: BorderSide(color: colors.outlineVariant)),
      child: Padding(
        padding: const EdgeInsets.all(Fievr001A14Tokens.spacingXl),
        child: Row(
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Assessment scoring', style: text.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: Fievr001A14Tokens.spacingXs),
                Text('MD3 tokens • structured select-free numeric capture', style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant)),
              ]),
            ),
            const SizedBox(width: Fievr001A14Tokens.spacingLg),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Fievr001A14Tokens.spacingLg, vertical: Fievr001A14Tokens.spacingMd),
              decoration: BoxDecoration(color: allPass && allFilled ? colors.primaryContainer : colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(Fievr001A14Tokens.bannerRadius)),
              child: Column(children: [
                Text(allFilled ? average.toStringAsFixed(1) : '—', style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                Text('AVG SCORE', style: text.labelSmall?.copyWith(color: colors.onSurfaceVariant)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreField extends StatelessWidget {
  const _ScoreField({required this.criterion, required this.controller, required this.validator});
  final ScoringCriterionA14 criterion;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Fievr001A14Tokens.cardRadius), side: BorderSide(color: theme.colorScheme.outlineVariant)),
      child: Padding(
        padding: const EdgeInsets.all(Fievr001A14Tokens.spacingLg),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(criterion.label, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: Fievr001A14Tokens.spacingXs),
          Text(criterion.description, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: Fievr001A14Tokens.spacingMd),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
            decoration: InputDecoration(
              labelText: 'Score (${criterion.minScore}–${criterion.maxScore})',
              hintText: '0–10',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(Fievr001A14Tokens.fieldRadius)),
              prefixIcon: const Icon(Icons.score_outlined),
              filled: true,
            ),
          ),
        ]),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.allPass, required this.allFilled, required this.threshold});
  final bool allPass;
  final bool allFilled;
  final int threshold;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final locked = !(allFilled && allPass);
    return Container(
      padding: const EdgeInsets.all(Fievr001A14Tokens.spacingMd),
      decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(Fievr001A14Tokens.bannerRadius)),
      child: Row(children: [
        Icon(locked ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: locked ? colors.onSurfaceVariant : colors.primary),
        const SizedBox(width: Fievr001A14Tokens.spacingMd),
        Expanded(child: Text(locked ? 'Profile discoverability locked until all rows ≥ $threshold.' : 'All rows pass — profile discoverable.', style: text.bodyMedium)),
      ]),
    );
  }
}

class _OfflineWarningBanner extends StatelessWidget {
  const _OfflineWarningBanner({required this.onReactivate});
  final VoidCallback? onReactivate;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // High-contrast warning banner per Mobile UI decision.
    return Container(
      padding: const EdgeInsets.all(Fievr001A14Tokens.spacingLg),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(Fievr001A14Tokens.bannerRadius),
        border: Border.all(color: theme.colorScheme.error, width: 1.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.warning_amber_rounded, color: theme.colorScheme.onErrorContainer),
          const SizedBox(width: Fievr001A14Tokens.spacingSm),
          Expanded(child: Text('Profile hidden — complete assessment to restore visibility', style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onErrorContainer, fontWeight: FontWeight.w700))),
        ]),
        const SizedBox(height: Fievr001A14Tokens.spacingSm),
        Text('Clear communication: hidden pending quality passes. Re-activate when back online if eligible.', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onErrorContainer)),
        const SizedBox(height: Fievr001A14Tokens.spacingMd),
        FilledButton.tonalIcon(onPressed: onReactivate, icon: const Icon(Icons.wifi_outlined), label: const Text('I am back online')),
      ]),
    );
  }
}
