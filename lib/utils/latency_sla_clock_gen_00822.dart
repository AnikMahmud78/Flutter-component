// GEN-00822 — Real-Time Performance Clock & Latency SLA Monitor (Flutter/Dart port of clock_decorator.py).
// Reusable timing wrapper that measures sync/async operation latency, evaluates it against a
// configurable SLA threshold (default sub-100ms mobile target), and emits structured metric
// events aligned to BigQuery streaming (partitioned by event_date, clustered by trace_id).

import 'dart:async';

/// Completion status captured for every measured operation.
enum LatencyCompletionStatus { complete, notComplete }

/// Immutable configuration for the latency SLA monitor.
///
/// Metric: 'Syntax Validity' analogue — every measured operation must complete
/// within [slaThreshold] (floor = optimal = 100% of executions inside the SLA).
class LatencySlaConfig {
  const LatencySlaConfig({
    this.slaThreshold = const Duration(milliseconds: 100),
    this.metricName = 'Syntax Validity',
    this.referenceStandard = 'PEP 8 Conventions',
  });

  /// Maximum allowed latency for an operation to be considered within SLA.
  /// Defaults to the sub-100ms mobile API response target.
  final Duration slaThreshold;

  /// Name of the governing metric for this monitor.
  final String metricName;

  /// Reference standard/spec the implementation is validated against.
  final String referenceStandard;
}

/// Structured metric event emitted for every measured execution.
///
/// Shape is designed for direct streaming into BigQuery:
/// partitioned by [eventDate], clustered by [traceId].
class LatencyEvent {
  const LatencyEvent({
    required this.traceId,
    required this.operationName,
    required this.elapsed,
    required this.isWithinSla,
    required this.status,
    required this.timestamp,
    this.sessionId,
    this.metadata = const <String, Object?>{},
  });

  /// Unique trace identifier used for BigQuery clustering.
  final String traceId;

  /// Human-readable name of the measured operation.
  final String operationName;

  /// Measured wall-clock duration of the operation.
  final Duration elapsed;

  /// Whether the operation completed within the configured SLA threshold.
  final bool isWithinSla;

  /// Output field captured per requirement: Complete / Not Complete.
  final LatencyCompletionStatus status;

  /// UTC timestamp of the event (action/event timestamp).
  final DateTime timestamp;

  /// Optional user/session identifier collected by the system.
  final String? sessionId;

  /// Optional additional context attached to the event.
  final Map<String, Object?> metadata;

  /// BigQuery partition key derived from [timestamp] (YYYY-MM-DD).
  String get eventDate =>
      '${timestamp.year.toString().padLeft(4, '0')}-'
      '${timestamp.month.toString().padLeft(2, '0')}-'
      '${timestamp.day.toString().padLeft(2, '0')}';

  /// Serializes the event for BigQuery streaming insertion.
  Map<String, Object?> toJson() => <String, Object?>{
        'trace_id': traceId,
        'operation_name': operationName,
        'elapsed_ms': elapsed.inMicroseconds / 1000.0,
        'is_within_sla': isWithinSla,
        'status': status == LatencyCompletionStatus.complete
            ? 'Complete'
            : 'Not Complete',
        'event_timestamp': timestamp.toIso8601String(),
        'event_date': eventDate,
        'session_id': sessionId,
        'metadata': metadata,
      };
}

/// Dart equivalent of the Python `clock_decorator.py`.
///
/// Wraps synchronous and asynchronous operations with a real-time performance
/// clock, validates latency against the configured SLA, and broadcasts
/// [LatencyEvent]s on a shared stream for downstream BigQuery sinks,
/// liveness handshakes, and rollback triggers.
class LatencySlaClock {
  LatencySlaClock({
    LatencySlaConfig config = const LatencySlaConfig(),
    String Function()? traceIdGenerator,
  })  : _config = config,
        _traceIdGenerator = traceIdGenerator ?? _defaultTraceId;

  final LatencySlaConfig _config;
  final String Function() _traceIdGenerator;

  final StreamController<LatencyEvent> _eventController =
      StreamController<LatencyEvent>.broadcast();

  /// Broadcast stream of all emitted latency metric events.
  Stream<LatencyEvent> get events => _eventController.stream;

  static int _traceCounter = 0;

  static String _defaultTraceId() {
    _traceCounter++;
    return 'gen-00822-'
        '${DateTime.now().toUtc().microsecondsSinceEpoch}-'
        '${_traceCounter.toRadixString(16)}';
  }

  /// Measures a synchronous operation (decorator equivalent).
  ///
  /// Returns the operation's result and emits a [LatencyEvent].
  /// Throws nothing itself; failures are captured as `Not Complete` events
  /// and rethrown so callers keep full error visibility.
  T measure<T>(
    String operationName,
    T Function() operation, {
    String? sessionId,
    Map<String, Object?> metadata = const <String, Object?>{},
  }) {
    final Stopwatch stopwatch = Stopwatch()..start();
    try {
      final T result = operation();
      stopwatch.stop();
      _emit(
        operationName: operationName,
        elapsed: stopwatch.elapsed,
        status: LatencyCompletionStatus.complete,
        sessionId: sessionId,
        metadata: metadata,
      );
      return result;
    } catch (_) {
      stopwatch.stop();
      _emit(
        operationName: operationName,
        elapsed: stopwatch.elapsed,
        status: LatencyCompletionStatus.notComplete,
        sessionId: sessionId,
        metadata: metadata,
      );
      rethrow;
    }
  }

  /// Measures an asynchronous operation (decorator equivalent).
  ///
  /// Returns the awaited result and emits a [LatencyEvent]. Failures are
  /// captured as `Not Complete` events and rethrown.
  Future<T> measureAsync<T>(
    String operationName,
    Future<T> Function() operation, {
    String? sessionId,
    Map<String, Object?> metadata = const <String, Object?>{},
  }) async {
    final Stopwatch stopwatch = Stopwatch()..start();
    try {
      final T result = await operation();
      stopwatch.stop();
      _emit(
        operationName: operationName,
        elapsed: stopwatch.elapsed,
        status: LatencyCompletionStatus.complete,
        sessionId: sessionId,
        metadata: metadata,
      );
      return result;
    } catch (_) {
      stopwatch.stop();
      _emit(
        operationName: operationName,
        elapsed: stopwatch.elapsed,
        status: LatencyCompletionStatus.notComplete,
        sessionId: sessionId,
        metadata: metadata,
      );
      rethrow;
    }
  }

  void _emit({
    required String operationName,
    required Duration elapsed,
    required LatencyCompletionStatus status,
    String? sessionId,
    Map<String, Object?> metadata = const <String, Object?>{},
  }) {
    final LatencyEvent event = LatencyEvent(
      traceId: _traceIdGenerator(),
      operationName: operationName,
      elapsed: elapsed,
      isWithinSla: elapsed <= _config.slaThreshold,
      status: status,
      timestamp: DateTime.now().toUtc(),
      sessionId: sessionId,
      metadata: metadata,
    );
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  /// Releases stream resources. Call when the monitor is no longer needed.
  Future<void> dispose() => _eventController.close();
}
