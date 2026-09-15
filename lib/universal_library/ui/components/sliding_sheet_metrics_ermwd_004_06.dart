// ERMWD-004-06 — Sliding Metrics Sheet with Down-Drag Dismiss & Quality Score.
// Pre-loaded granular cell metrics in DraggableScrollableSheet; async background queue with local state preservation, non-blocking Snackbars and Top App Bar loader.
import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';

/// ISO 9001:2015 aligned qualitative output. Best = Good (100%).
enum ExecutionQuality { good, average, poor }

/// Maps Process Execution Quality Score to qualitative output.
/// Floor >=0.90, Optimal >=0.98, Ceiling = 1.0
ExecutionQuality qualityFromScore(double score) {
  if (score >= 0.98) return ExecutionQuality.good;
  if (score >= 0.90) return ExecutionQuality.average;
  return ExecutionQuality.poor;
}

String qualityLabel(ExecutionQuality q) {
  switch (q) {
    case ExecutionQuality.good:
      return 'Good';
    case ExecutionQuality.average:
      return 'Average';
    case ExecutionQuality.poor:
      return 'Poor';
  }
}

/// Atomic-level data fields for Row 4670 / ERMWD-004-06.
class CellMetricRecord {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String sessionId;
  final DateTime actionTimestamp;
  final double qualityScore;

  const CellMetricRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.sessionId,
    required this.actionTimestamp,
    required this.qualityScore,
  });

  ExecutionQuality get quality => qualityFromScore(qualityScore);
}

/// Background queue with local state preservation. Never blocks UI.
class MetricsBackgroundQueue {
  final Queue<Future<void> Function()> _queue = Queue();
  bool _running = false;
  final List<CellMetricRecord> preservedState = [];

  bool get isRunning => _running;
  int get pendingCount => _queue.length;

  void enqueue(Future<void> Function() task) {
    _queue.add(task);
    _drain();
  }

  Future<void> _drain() async {
    if (_running) return;
    _running = true;
    while (_queue.isNotEmpty) {
      final task = _queue.removeFirst();
      try {
        await task();
      } catch (_) {
        // Preserve queue continuity; errors surfaced via UI callbacks.
      }
    }
    _running = false;
  }

  void dispose() => _queue.clear();
}

/// Pre-loaded granular cell metrics for instant sheet open.
List<CellMetricRecord> buildDefaultCellMetrics() {
  final now = DateTime.now();
  return List.generate(12, (i) {
    final score = i < 8 ? 0.98 + (i % 3) * 0.005 : (i == 8 ? 0.94 : 0.87);
    return CellMetricRecord(
      stepExecutionId: 'EXE-8862-${4670 + i}',
      executionStatus: i % 4 == 3 ? 'Retrying' : 'Completed',
      executionTimestamp: now.subtract(Duration(minutes: i * 7)),
      stepOutcome: i % 4 == 3 ? 'Deferred' : 'Success',
      userId: 'anik_${i % 3}',
      sessionId: 'sess_${DateTime.now().millisecondsSinceEpoch}_$i',
      actionTimestamp: now.subtract(Duration(minutes: i * 7)),
      qualityScore: score.clamp(0.0, 1.0),
    );
  });
}

/// Shows the sliding sheet. Standard downward-drag to dismiss.
Future<void> showErmwd00406MetricsSheet({
  required BuildContext context,
  required List<CellMetricRecord> metrics,
  required bool isProcessing,
  ValueChanged<CellMetricRecord>? onSelect,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (ctx) => Ermwd00406SlidingMetricsSheet(
      metrics: metrics,
      isProcessing: isProcessing,
      onSelect: onSelect,
    ),
  );
}

/// Sliding layout sheet container pre-loaded with granular cell metrics.
class Ermwd00406SlidingMetricsSheet extends StatelessWidget {
  final List<CellMetricRecord> metrics;
  final bool isProcessing;
  final ValueChanged<CellMetricRecord>? onSelect;

  const Ermwd00406SlidingMetricsSheet({
    super.key,
    required this.metrics,
    this.isProcessing = false,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.72,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.4, 0.72, 0.95],
      builder: (context, scrollController) {
        return CustomScrollView(
          key: const PageStorageKey<String>('ermwd_004_06_sheet_list'),
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cell Metrics', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      'Process Execution Quality Score • Floor ≥90% • Optimal ≥98% • ISO 9001:2015',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (isProcessing)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: LinearProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
            SliverList.builder(
              itemCount: metrics.length,
              itemBuilder: (context, index) {
                final m = metrics[index];
                final q = m.quality;
                final Color badgeColor = q == ExecutionQuality.good
                    ? theme.colorScheme.primary
                    : q == ExecutionQuality.average
                        ? theme.colorScheme.tertiary
                        : theme.colorScheme.error;
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: badgeColor.withOpacity(0.14),
                      child: Text(
                        '${(m.qualityScore * 100).toStringAsFixed(0)}',
                        style: TextStyle(color: badgeColor, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                    title: Text(m.stepExecutionId, style: theme.textTheme.titleSmall),
                    subtitle: Text('${m.executionStatus} • ${m.stepOutcome} • ${qualityLabel(q)}'),
                    trailing: const Icon(Icons.keyboard_arrow_up, size: 18),
                    onTap: () {
                      onSelect?.call(m);
                      Navigator.of(context).maybePop();
                    },
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        );
      },
    );
  }
}

/// Demo host: Top App Bar loader + Snackbar Processing + async state management.
class Ermwd00406MetricsDemoScreen extends StatefulWidget {
  const Ermwd00406MetricsDemoScreen({super.key});

  @override
  State<Ermwd00406MetricsDemoScreen> createState() => _Ermwd00406MetricsDemoScreenState();
}

class _Ermwd00406MetricsDemoScreenState extends State<Ermwd00406MetricsDemoScreen> {
  late List<CellMetricRecord> _metrics;
  final MetricsBackgroundQueue _bgQueue = MetricsBackgroundQueue();
  bool _isProcessing = false;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _metrics = buildDefaultCellMetrics();
    _bgQueue.preservedState.addAll(_metrics);
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _bgQueue.dispose();
    super.dispose();
  }

  void _refreshAsync() {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Processing...'), duration: Duration(seconds: 2)));
    _bgQueue.enqueue(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      final fresh = buildDefaultCellMetrics();
      setState(() {
        _metrics = fresh;
        _bgQueue.preservedState
          ..clear()
          ..addAll(fresh);
        _isProcessing = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Metrics updated • ${_metrics.length} cells • Quality Good ≥98%')),
        );
      }
    });
    _pollTimer?.cancel();
    _pollTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _bgQueue.pendingCount == 0 && _isProcessing) {
        setState(() => _isProcessing = false);
      }
    });
  }

  void _openSheet() {
    showErmwd00406MetricsSheet(
      context: context,
      metrics: _metrics,
      isProcessing: _isProcessing,
      onSelect: (m) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${m.stepExecutionId} • ${qualityLabel(m.quality)} • ${(m.qualityScore * 100).toStringAsFixed(1)}%')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Execution Metrics'),
        bottom: _isProcessing
            ? const PreferredSize(preferredSize: Size.fromHeight(4), child: LinearProgressIndicator(minHeight: 3))
            : null,
        actions: [
          IconButton(tooltip: 'Refresh', onPressed: _refreshAsync, icon: const Icon(Icons.refresh)),
          IconButton(tooltip: 'Open sheet', onPressed: _openSheet, icon: const Icon(Icons.vertical_align_bottom)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _refreshAsync(),
        child: ListView.builder(
          key: const PageStorageKey<String>('ermwd_004_06_host_list'),
          itemCount: _metrics.length,
          itemBuilder: (context, i) {
            final m = _metrics[i];
            return ListTile(
              title: Text(m.stepExecutionId),
              subtitle: Text('${m.userId} • ${m.executionTimestamp.toIso8601String()}'),
              trailing: Chip(label: Text(qualityLabel(m.quality))),
              onTap: _openSheet,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openSheet,
        icon: const Icon(Icons.swipe_down),
        label: const Text('View sheet'),
      ),
    );
  }
}
