// ERMWD-001-11 — Task Item Material Cards with Seamless Queue Loading.
// Material 3 task queue: paginated cards, real-time Stream updates (WebSocket equivalent), exception highlight for OCRConfidenceLow.
import 'dart:async';
import 'package:flutter/material.dart';

/// ISO 9001:2015 Quality Management Standard reference for this atomic step.
const String kIso9001Reference = 'ISO 9001:2015 Quality Management Standard';

/// Execution status for atomic step ERMWD-001-11.
enum TaskExecutionStatus { pending, running, succeeded, failed, skipped }

/// Outcome mapped to Good / Average / Poor (Best = Good).
enum QualityRating { good, average, poor }

/// Exception trigger example: OCRConfidenceLow.
enum ExceptionTrigger { none, ocrConfidenceLow, timeout, validationFailed }

/// Atomic-level data model: Step Execution ID, Status, Timestamp, Outcome, User ID.
@immutable
class TaskItem {
  final String stepExecutionId;
  final String title;
  final String subtitle;
  final TaskExecutionStatus executionStatus;
  final String stepOutcome;
  final DateTime executionTimestamp;
  final String userId;
  final QualityRating completionStatus;
  final double ocrConfidence;
  final ExceptionTrigger exceptionTrigger;

  const TaskItem({
    required this.stepExecutionId,
    required this.title,
    this.subtitle = '',
    required this.executionStatus,
    required this.stepOutcome,
    required this.executionTimestamp,
    required this.userId,
    this.completionStatus = QualityRating.good,
    this.ocrConfidence = 1.0,
    this.exceptionTrigger = ExceptionTrigger.none,
  });

  bool get hasException => exceptionTrigger != ExceptionTrigger.none || ocrConfidence < 0.75;

  TaskItem copyWith({
    TaskExecutionStatus? executionStatus,
    String? stepOutcome,
    DateTime? executionTimestamp,
    QualityRating? completionStatus,
    double? ocrConfidence,
    ExceptionTrigger? exceptionTrigger,
  }) {
    return TaskItem(
      stepExecutionId: stepExecutionId,
      title: title,
      subtitle: subtitle,
      executionStatus: executionStatus ?? this.executionStatus,
      stepOutcome: stepOutcome ?? this.stepOutcome,
      executionTimestamp: executionTimestamp ?? this.executionTimestamp,
      userId: userId,
      completionStatus: completionStatus ?? this.completionStatus,
      ocrConfidence: ocrConfidence ?? this.ocrConfidence,
      exceptionTrigger: exceptionTrigger ?? this.exceptionTrigger,
    );
  }
}

/// Process Execution Quality Score helper. Floor >=90%, Optimal >=98%, Ceiling 1.0 (100%).
class ProcessExecutionQuality {
  static const double floorBoundary = 0.90;
  static const double optimalTarget = 0.98;
  static const double ceilingBoundary = 1.0;

  static double score({required int goodCount, required int totalCount}) {
    if (totalCount <= 0) return 1.0;
    return (goodCount / totalCount).clamp(0.0, 1.0);
  }

  static QualityRating ratingFor(double scoreValue) {
    if (scoreValue >= optimalTarget) return QualityRating.good;
    if (scoreValue >= floorBoundary) return QualityRating.average;
    return QualityRating.poor;
  }

  static String labelFor(QualityRating rating) {
    switch (rating) {
      case QualityRating.good:
        return 'Good';
      case QualityRating.average:
        return 'Average';
      case QualityRating.poor:
        return 'Poor';
    }
  }
}

/// Controller that replaces WebSocket/React state updates with Dart Streams + ChangeNotifier.
/// Provides seamless queue loading (pagination) and real-time list updates.
class TaskQueueController extends ChangeNotifier {
  TaskQueueController({Stream<List<TaskItem>>? realtimeSource, this.pageSize = 20}) {
    if (realtimeSource != null) {
      _realtimeSub = realtimeSource.listen(_applyRealtimeBatch);
    }
  }

  final int pageSize;
  final List<TaskItem> _items = [];
  final StreamController<List<TaskItem>> _updatesController = StreamController.broadcast();
  StreamSubscription<List<TaskItem>>? _realtimeSub;
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  String? _error;

  List<TaskItem> get items => List.unmodifiable(_items);
  Stream<List<TaskItem>> get updates => _updatesController.stream;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;

  double get qualityScore => ProcessExecutionQuality.score(
        goodCount: _items.where((e) => e.completionStatus == QualityRating.good).length,
        totalCount: _items.length,
      );

  QualityRating get qualityRating => ProcessExecutionQuality.ratingFor(qualityScore);

  Future<void> loadInitial(Future<List<TaskItem>> Function(int page, int pageSize) fetcher) async {
    _page = 0;
    _items.clear();
    _hasMore = true;
    _error = null;
    await loadMore(fetcher);
  }

  Future<void> loadMore(Future<List<TaskItem>> Function(int page, int pageSize) fetcher) async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final batch = await fetcher(_page, pageSize);
      if (batch.length < pageSize) _hasMore = false;
      _page++;
      _items.addAll(batch);
      _updatesController.add(List.unmodifiable(_items));
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _applyRealtimeBatch(List<TaskItem> batch) {
    final map = {for (final t in _items) t.stepExecutionId: t};
    for (final incoming in batch) {
      map[incoming.stepExecutionId] = incoming;
    }
    _items
      ..clear()
      ..addAll(map.values);
    _items.sort((a, b) => b.executionTimestamp.compareTo(a.executionTimestamp));
    _updatesController.add(List.unmodifiable(_items));
    notifyListeners();
  }

  void upsert(TaskItem item) => _applyRealtimeBatch([item]);

  void removeById(String stepExecutionId) {
    _items.removeWhere((e) => e.stepExecutionId == stepExecutionId);
    _updatesController.add(List.unmodifiable(_items));
    notifyListeners();
  }

  @override
  void dispose() {
    _realtimeSub?.cancel();
    _updatesController.close();
    super.dispose();
  }
}

/// Material 3 Card for a single task queue item.
class TaskItemMaterialCard extends StatelessWidget {
  const TaskItemMaterialCard({super.key, required this.item, this.onTap, this.onRetry});

  final TaskItem item;
  final VoidCallback? onTap;
  final VoidCallback? onRetry;

  Color _statusColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (item.executionStatus) {
      case TaskExecutionStatus.succeeded:
        return scheme.primary;
      case TaskExecutionStatus.running:
        return scheme.tertiary;
      case TaskExecutionStatus.failed:
        return scheme.error;
      case TaskExecutionStatus.pending:
        return scheme.outline;
      case TaskExecutionStatus.skipped:
        return scheme.secondary;
    }
  }

  IconData _statusIcon() {
    switch (item.executionStatus) {
      case TaskExecutionStatus.succeeded:
        return Icons.check_circle_rounded;
      case TaskExecutionStatus.running:
        return Icons.autorenew_rounded;
      case TaskExecutionStatus.failed:
        return Icons.error_rounded;
      case TaskExecutionStatus.pending:
        return Icons.schedule_rounded;
      case TaskExecutionStatus.skipped:
        return Icons.skip_next_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final statusColor = _statusColor(context);

    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(_statusIcon(), color: statusColor, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(item.title, style: theme.textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  _QualityChip(rating: item.completionStatus),
                ],
              ),
              if (item.subtitle.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(item.subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text(item.executionStatus.name.toUpperCase()), visualDensity: VisualDensity.compact),
                  Chip(label: Text('ID ${item.stepExecutionId}'), visualDensity: VisualDensity.compact),
                  Chip(label: Text('User ${item.userId}'), visualDensity: VisualDensity.compact),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text('Outcome: ${item.stepOutcome}', style: theme.textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  Text(_formatTime(item.executionTimestamp), style: theme.textTheme.labelSmall?.copyWith(color: scheme.outline)),
                ],
              ),
              if (item.hasException) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: scheme.errorContainer, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, size: 18, color: scheme.onErrorContainer),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.exceptionTrigger == ExceptionTrigger.ocrConfidenceLow ? 'OCRConfidenceLow (${(item.ocrConfidence * 100).toStringAsFixed(1)}%)' : 'Exception: ${item.exceptionTrigger.name}',
                          style: theme.textTheme.labelMedium?.copyWith(color: scheme.onErrorContainer),
                        ),
                      ),
                      if (onRetry != null)
                        TextButton(onPressed: onRetry, child: const Text('Retry')),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) => '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}

class _QualityChip extends StatelessWidget {
  const _QualityChip({required this.rating});
  final QualityRating rating;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final Color bg;
    switch (rating) {
      case QualityRating.good:
        bg = scheme.primaryContainer;
        break;
      case QualityRating.average:
        bg = scheme.tertiaryContainer;
        break;
      case QualityRating.poor:
        bg = scheme.errorContainer;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(ProcessExecutionQuality.labelFor(rating), style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

/// Seamless queue list: infinite scroll + pull-to-refresh + real-time Stream updates.
class TaskQueueListView extends StatefulWidget {
  const TaskQueueListView({super.key, required this.controller, required this.fetcher, this.onItemTap});

  final TaskQueueController controller;
  final Future<List<TaskItem>> Function(int page, int pageSize) fetcher;
  final void Function(TaskItem item)? onItemTap;

  @override
  State<TaskQueueListView> createState() => _TaskQueueListViewState();
}

class _TaskQueueListViewState extends State<TaskQueueListView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    if (widget.controller.items.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => widget.controller.loadInitial(widget.fetcher));
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 240) {
      widget.controller.loadMore(widget.fetcher);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final items = widget.controller.items;
        if (widget.controller.error != null && items.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off_rounded, size: 40),
                const SizedBox(height: 8),
                Text(widget.controller.error!),
                const SizedBox(height: 8),
                FilledButton(onPressed: () => widget.controller.loadInitial(widget.fetcher), child: const Text('Retry')),
              ],
            ),
          );
        }
        if (items.isEmpty && widget.controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (items.isEmpty) {
          return const Center(child: Text('No tasks in queue'));
        }
        return RefreshIndicator(
          onRefresh: () => widget.controller.loadInitial(widget.fetcher),
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            itemCount: items.length + (widget.controller.hasMore ? 1 : 0),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              if (index >= items.length) {
                return const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Center(child: CircularProgressIndicator()));
              }
              final item = items[index];
              return TaskItemMaterialCard(item: item, onTap: () => widget.onItemTap?.call(item));
            },
          ),
        );
      },
    );
  }
}
