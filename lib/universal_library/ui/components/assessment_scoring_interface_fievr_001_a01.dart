// FIEVR-001-A01 — Assessment Scoring Interface Integration.
// Structured scorecard with numeric-only select wheels, frozen submit until complete, and locked discoverability banner with reactivation.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Grading rubric dimension for FIEVR-001-A01.
class AssessmentCriterion {
  AssessmentCriterion({
    required this.id,
    required this.skillDimension,
    required this.maxScore,
    required this.passThreshold,
    this.score,
  });

  final String id;
  final String skillDimension;
  final int maxScore;
  final int passThreshold;
  int? score;

  bool get hasScore => score != null;
  bool get isPass => hasScore && score! >= passThreshold;
  List<int> get allowedValues => List<int>.generate(maxScore + 1, (i) => i);
}

/// Integrated assessment scoring forms connected to backend tracking layers.
///
/// Enforces numeric-only structured capture via select wheels, locks profile
/// discoverability until all rows pass, and links saves to downstream index updates.
class AssessmentScoringInterface extends StatefulWidget {
  const AssessmentScoringInterface({
    super.key,
    required this.userId,
    required this.applicantId,
    this.initialCriteria,
    this.onIndexUpdated,
  });

  final String userId;
  final String applicantId;
  final List<AssessmentCriterion>? initialCriteria;
  final ValueChanged<DateTime>? onIndexUpdated;

  @override
  State<AssessmentScoringInterface> createState() => _AssessmentScoringInterfaceState();
}

class _AssessmentScoringInterfaceState extends State<AssessmentScoringInterface> {
  late List<AssessmentCriterion> _criteria;
  bool _isSaving = false;
  bool _isOnline = true;
  bool _exceptionFrozen = false;
  String _executionStatus = 'pending';
  DateTime? _lastSavedAt;
  String? _ticketId;

  @override
  void initState() {
    super.initState();
    _criteria = widget.initialCriteria ??
        [
          AssessmentCriterion(id: 'clinical-safety', skillDimension: 'Clinical Safety', maxScore: 10, passThreshold: 7),
          AssessmentCriterion(id: 'communication', skillDimension: 'Communication', maxScore: 10, passThreshold: 7),
          AssessmentCriterion(id: 'ethics', skillDimension: 'Ethics & Compliance', maxScore: 10, passThreshold: 8),
          AssessmentCriterion(id: 'technical', skillDimension: 'Technical Proficiency', maxScore: 10, passThreshold: 7),
        ];
  }

  bool get _allScored => _criteria.every((c) => c.hasScore);
  bool get _allPassed => _criteria.isNotEmpty && _criteria.every((c) => c.isPass);
  bool get _isDiscoverable => _allPassed && !_exceptionFrozen;
  bool get _canSubmit => _allScored && !_isSaving && !_exceptionFrozen;
  double get _coverage => _criteria.isEmpty ? 0 : _criteria.where((c) => c.hasScore).length / _criteria.length;
  double get _avgScore {
    final scored = _criteria.where((c) => c.hasScore).toList();
    if (scored.isEmpty) return 0;
    return scored.map((c) => c.score!).reduce((a, b) => a + b) / scored.length;
  }

  void _logVerification(String action) {
    // GCP / BigQuery alignment: real-time logging of verification actions.
    // HC-API-0033 Asynchronous Triggers hook point.
    debugPrint('[FIEVR-001-A01] $action user=${widget.userId} applicant=${widget.applicantId} status=$_executionStatus time=${DateTime.now().toIso8601String()}');
  }

  void _onScoreSelected(AssessmentCriterion criterion, int? value) {
    if (value == null) return;
    setState(() {
      criterion.score = value;
      // Self-chasing: grade exception freezes channel + raises ticket.
      if (value < 0 || value > criterion.maxScore) {
        _exceptionFrozen = true;
        _ticketId = 'DQ-${DateTime.now().millisecondsSinceEpoch}';
        _executionStatus = 'exception';
      } else if (_exceptionFrozen && _criteria.every((c) => c.hasScore && (c.score! >= 0 && c.score! <= c.maxScore))) {
        _exceptionFrozen = false;
        _ticketId = null;
        _executionStatus = 'pending';
      }
    });
    _logVerification('score_update:${criterion.id}=$value');
  }

  Future<void> _handleSave() async {
    if (!_canSubmit) return;
    setState(() {
      _isSaving = true;
      _executionStatus = 'running';
    });
    _logVerification('assessment_save_started');
    try {
      // Simulate secure backend persistent save + downstream index update event.
      await Future<void>.delayed(const Duration(milliseconds: 900));
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _executionStatus = 'succeeded';
        _lastSavedAt = DateTime.now();
      });
      _logVerification('index_update_triggered');
      widget.onIndexUpdated?.call(_lastSavedAt!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isDiscoverable ? 'Scores saved. Profile discoverable.' : 'Scores saved. Profile remains hidden until all passes.')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _executionStatus = 'failed';
        _exceptionFrozen = true;
        _ticketId = 'DQ-${DateTime.now().millisecondsSinceEpoch}';
      });
    }
  }

  void _handleReactivation() {
    setState(() => _isOnline = true);
    _logVerification('reactivation_tap');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reactivation requested. You are back online.')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatusHeader(theme),
              const SizedBox(height: 12),
              if (!_isDiscoverable) _buildHiddenBanner(colorScheme),
              if (_exceptionFrozen) _buildExceptionAlert(colorScheme),
              const SizedBox(height: 12),
              Text('Scorecard — ${_criteria.length} skill dimensions', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              _buildScoreGrid(isNarrow),
              const SizedBox(height: 16),
              _buildStatsPanel(theme),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _canSubmit ? _handleSave : null,
                icon: _isSaving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.save_outlined),
                label: Text(_allScored ? 'Save assessment & update index' : 'Complete all ${_criteria.length} scores to unlock submit (${(_coverage * 100).toStringAsFixed(0)}%)'),
              ),
              if (!_allScored)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('Submission locked until every scoring box has a value (poka-yoke).', style: theme.textTheme.bodySmall),
                ),
              if (!_isOnline)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: FilledButton.tonalIcon(onPressed: _handleReactivation, icon: const Icon(Icons.wifi_find), label: const Text('I am back online')),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusHeader(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Chip(label: Text('Status: $_executionStatus')),
            Chip(label: Text('Coverage: ${(_coverage * 100).toStringAsFixed(0)}%')),
            Chip(label: Text('Avg: ${_avgScore.toStringAsFixed(1)}')),
            if (_lastSavedAt != null) Text('Saved: ${_lastSavedAt.toString()}', style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildHiddenBanner(ColorScheme colorScheme) {
    // High-contrast warning + clear communication why hidden (Material alert).
    return MaterialBanner(
      backgroundColor: colorScheme.errorContainer,
      contentTextStyle: TextStyle(color: colorScheme.onErrorContainer),
      leading: Icon(Icons.visibility_off, color: colorScheme.onErrorContainer),
      content: const Text('Profile hidden: discoverability unlocks only after all assessment rows pass. Complete scoring to advance status.'),
      actions: [
        TextButton(onPressed: () => setState(() => _isOnline = false), child: const Text('VIEW POLICY')),
      ],
    );
  }

  Widget _buildExceptionAlert(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colorScheme.error, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(Icons.report, color: colorScheme.onError),
          const SizedBox(width: 8),
          Expanded(child: Text('Data correction ticket ${_ticketId ?? ''} raised. Processing frozen until fixed.', style: TextStyle(color: colorScheme.onError, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildScoreGrid(bool isNarrow) {
    if (isNarrow) {
      return Column(children: [for (final c in _criteria) _buildScoreCard(c)]);
    }
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [for (final c in _criteria) _buildScoreCard(c)],
    );
  }

  Widget _buildScoreCard(AssessmentCriterion c) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Expanded(child: Text(c.skillDimension, style: const TextStyle(fontWeight: FontWeight.w600))), _passChip(c)]),
            Text('Pass ≥ ${c.passThreshold} / ${c.maxScore}', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            // Clean select wheel over free-form box: numeric-only structured capture.
            DropdownButtonFormField<int>(
              initialValue: c.score,
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Score', prefixIcon: Icon(Icons.scoreboard_outlined)),
              items: [for (final v in c.allowedValues) DropdownMenuItem(value: v, child: Text('$v'))],
              onChanged: _exceptionFrozen ? null : (v) => _onScoreSelected(c, v),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) => v == null ? 'Required' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _passChip(AssessmentCriterion c) {
    if (!c.hasScore) return const Chip(label: Text('Pending'), visualDensity: VisualDensity.compact);
    final pass = c.isPass;
    return Chip(
      visualDensity: VisualDensity.compact,
      backgroundColor: pass ? Colors.green.shade100 : Colors.orange.shade100,
      label: Text(pass ? 'Pass' : 'Review'),
    );
  }

  Widget _buildStatsPanel(ThemeData theme) {
    final passed = _criteria.where((c) => c.isPass).length;
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Operational tracking — pass statistics', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: _criteria.isEmpty ? 0 : passed / _criteria.length),
            const SizedBox(height: 8),
            Text('$passed / ${_criteria.length} criteria passed • Cohort rank: ${_avgScore >= 8 ? 'Top 10%' : _avgScore >= 7 ? 'Top 25%' : 'In review'}', style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
