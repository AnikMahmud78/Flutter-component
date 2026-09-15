// ETMDI-009-12 — Poka-Yoke Sealed Mask & Locked Status Indicator.
// Translates PDCA outcomes into hardcoded UI constraints: locked banner with Material Lock icon, masked content, hidden edit FAB, and seal-confirmation Snackbar with Freshness SLA rating.
import 'package:flutter/material.dart';

/// Freshness SLA rating per Google Cloud Data Engineering SRE benchmark.
/// Ceiling: <=1 min = Good, Optimal: <=5 min = Average, Floor: <=15 min = Poor.
enum FreshnessRating { good, average, poor }

/// Evaluates Data Pipeline Latency (Freshness SLA) for ETMDI-009-12.
class FreshnessSlaEvaluator {
  static const Duration ceiling = Duration(minutes: 1);
  static const Duration optimal = Duration(minutes: 5);
  static const Duration floor = Duration(minutes: 15);

  static FreshnessRating evaluate(Duration latency) {
    if (latency <= ceiling) return FreshnessRating.good;
    if (latency <= optimal) return FreshnessRating.average;
    return FreshnessRating.poor;
  }

  static String label(FreshnessRating rating) {
    switch (rating) {
      case FreshnessRating.good:
        return 'Good (\u22641 min)';
      case FreshnessRating.average:
        return 'Average (\u22645 min)';
      case FreshnessRating.poor:
        return 'Poor (\u226415 min)';
    }
  }

  static Color color(BuildContext context, FreshnessRating rating) {
    final scheme = Theme.of(context).colorScheme;
    switch (rating) {
      case FreshnessRating.good:
        return scheme.primary;
      case FreshnessRating.average:
        return scheme.tertiary;
      case FreshnessRating.poor:
        return scheme.error;
    }
  }
}

/// Poka-Yoke hardcoded constraint wrapper.
///
/// When [isSealed] is true: content is masked/disabled, locked banner is shown,
/// and [editFab] is removed (Poka-Yoke). When false: content is editable and
/// seal action is available. Seal confirmation is reported via Snackbar.
class PokaYokeSealedMaskEtmdi00912 extends StatelessWidget {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final Duration pipelineLatency;
  final bool isSealed;
  final Widget child;
  final Widget? editFab;
  final VoidCallback? onSeal;
  final VoidCallback? onRequestUnseal;

  const PokaYokeSealedMaskEtmdi00912({
    super.key,
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.pipelineLatency,
    required this.child,
    this.isSealed = false,
    this.editFab,
    this.onSeal,
    this.onRequestUnseal,
  });

  void _confirmSeal(BuildContext context) {
    final rating = FreshnessSlaEvaluator.evaluate(pipelineLatency);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: [
              const Icon(Icons.lock_outline, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Sealed $stepExecutionId \u2022 ${FreshnessSlaEvaluator.label(rating)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onInverseSurface),
                ),
              ),
            ],
          ),
        ),
      );
    onSeal?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rating = FreshnessSlaEvaluator.evaluate(pipelineLatency);
    final ratingColor = FreshnessSlaEvaluator.color(context, rating);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDCA Poka-Yoke Seal'),
        actions: [
          _LockedStatusChip(isSealed: isSealed),
          const SizedBox(width: 8),
        ],
      ),
      // Poka-Yoke: removal of edit FABs when sealed.
      floatingActionButton: isSealed ? null : (editFab ?? FloatingActionButton(
        onPressed: () => _confirmSeal(context),
        tooltip: 'Seal step',
        child: const Icon(Icons.lock_open_outlined),
      )),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SealBanner(
            isSealed: isSealed,
            stepExecutionId: stepExecutionId,
            executionStatus: executionStatus,
            ratingLabel: FreshnessSlaEvaluator.label(rating),
            ratingColor: ratingColor,
          ),
          const SizedBox(height: 12),
          _MetaCard(
            stepExecutionId: stepExecutionId,
            executionStatus: executionStatus,
            executionTimestamp: executionTimestamp,
            stepOutcome: stepOutcome,
            userId: userId,
            pipelineLatency: pipelineLatency,
            rating: rating,
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Opacity(
                opacity: isSealed ? 0.55 : 1.0,
                child: IgnorePointer(
                  ignoring: isSealed,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: child,
                    ),
                  ),
                ),
              ),
              if (isSealed)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Tooltip(
                    message: 'Locked by Poka-Yoke',
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.lock, size: 20, color: theme.colorScheme.onSurfaceVariant, semanticLabel: 'Locked'),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (isSealed)
            OutlinedButton.icon(
              onPressed: onRequestUnseal,
              icon: const Icon(Icons.lock_outline),
              label: const Text('Request unseal (TC Implementer sign-off required)'),
            )
          else
            FilledButton.icon(
              onPressed: () => _confirmSeal(context),
              icon: const Icon(Icons.lock),
              label: const Text('Seal with Poka-Yoke constraints'),
            ),
        ],
      ),
    );
  }
}

class _LockedStatusChip extends StatelessWidget {
  final bool isSealed;
  const _LockedStatusChip({required this.isSealed});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Chip(
      avatar: Icon(isSealed ? Icons.lock : Icons.lock_open_outlined, size: 16, color: isSealed ? scheme.onPrimary : scheme.primary),
      label: Text(isSealed ? 'Locked' : 'Unlocked'),
      backgroundColor: isSealed ? scheme.primary : scheme.surfaceContainerHighest,
      labelStyle: TextStyle(color: isSealed ? scheme.onPrimary : scheme.onSurfaceVariant),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _SealBanner extends StatelessWidget {
  final bool isSealed;
  final String stepExecutionId;
  final String executionStatus;
  final String ratingLabel;
  final Color ratingColor;
  const _SealBanner({required this.isSealed, required this.stepExecutionId, required this.executionStatus, required this.ratingLabel, required this.ratingColor});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSealed ? scheme.primaryContainer : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(isSealed ? Icons.lock : Icons.lock_open_outlined, color: isSealed ? scheme.onPrimaryContainer : scheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isSealed ? 'Hardcoded Poka-Yoke active' : 'Editable — PDCA not yet sealed', style: Theme.of(context).textTheme.titleSmall),
                Text('$stepExecutionId \u2022 $executionStatus', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: ratingColor.withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: ratingColor)),
            child: Text(ratingLabel, style: TextStyle(color: ratingColor, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _MetaCard extends StatelessWidget {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final Duration pipelineLatency;
  final FreshnessRating rating;
  const _MetaCard({required this.stepExecutionId, required this.executionStatus, required this.executionTimestamp, required this.stepOutcome, required this.userId, required this.pipelineLatency, required this.rating});

  String _fmtLatency(Duration d) {
    if (d.inSeconds < 60) return '${d.inSeconds}s';
    return '${d.inMinutes}m ${d.inSeconds % 60}s';
  }

  @override
  Widget build(BuildContext context) {
    Widget row(String k, String v) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 140, child: Text(k, style: Theme.of(context).textTheme.bodySmall)),
            Expanded(child: Text(v, style: Theme.of(context).textTheme.bodyMedium, semanticsLabel: '$k $v')),
          ],
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Execution audit', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            row('Step Execution ID', stepExecutionId),
            row('Execution Status', executionStatus),
            row('Execution Timestamp', executionTimestamp.toIso8601String()),
            row('Step Outcome', stepOutcome),
            row('User ID', userId),
            row('Pipeline Latency', '${_fmtLatency(pipelineLatency)} (${FreshnessSlaEvaluator.label(rating)})'),
            row('SLA Target', '\u226415m floor / \u22645m optimal / \u22641m ceiling'),
          ],
        ),
      ),
    );
  }
}
