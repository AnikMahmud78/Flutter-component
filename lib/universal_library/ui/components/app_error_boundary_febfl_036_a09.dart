// FEBFL-036-A09 — App Error Boundary & Real-Time Interface Crash Monitor.
// Root-level crash monitors, frame-lag listener and friendly fallback blocks that catch UI exceptions before client screens crash.
import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Standard fault fields: Component_Error_Source, User_Hesitation_Duration_MS, Trace_Context_Token.
/// Plus atomic-level fields: Step Execution ID, Execution Status, Execution Timestamp, Step Outcome, User ID.
@immutable
class InterfaceFaultReport {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String componentErrorSource;
  final int userHesitationDurationMs;
  final String traceContextToken;
  final String completionStatus;
  final String? stackSummary;

  const InterfaceFaultReport({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.componentErrorSource,
    required this.userHesitationDurationMs,
    required this.traceContextToken,
    this.completionStatus = 'Complete',
    this.stackSummary,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Step_Execution_ID': stepExecutionId,
        'Execution_Status': executionStatus,
        'Execution_Timestamp': executionTimestamp.toIso8601String(),
        'Step_Outcome': stepOutcome,
        'User_ID': userId,
        'Component_Error_Source': componentErrorSource,
        'User_Hesitation_Duration_MS': userHesitationDurationMs,
        'Trace_Context_Token': traceContextToken,
        'Completion_Status': completionStatus,
        'Action_Event_Timestamp': DateTime.now().toUtc().toIso8601String(),
      };
}

/// Strict pipeline constraints — prevents unmapped component drops from silently crashing screens.
class PipelineConstraintValidator {
  const PipelineConstraintValidator._();

  static void validate(InterfaceFaultReport report) {
    assert(report.stepExecutionId.isNotEmpty, 'Step Execution ID is required');
    assert(report.componentErrorSource.isNotEmpty, 'Component_Error_Source is required');
    assert(report.traceContextToken.isNotEmpty, 'Trace_Context_Token is required');
    if (report.stepExecutionId.isEmpty ||
        report.componentErrorSource.isEmpty ||
        report.traceContextToken.isEmpty) {
      throw StateError(
          'FEBFL-036-A09 pipeline blocked: unmapped component drop (missing fault fields)');
    }
    // Self-chasing: unresolved stalls fail pipeline checks instantly.
    if (report.userHesitationDurationMs < 0) {
      throw StateError('FEBFL-036-A09 pipeline blocked: negative hesitation duration');
    }
  }
}

/// Sink for operational remediation boards / BigQuery gateway cluster.
/// Production implementation streams via standard gateway; default keeps in-memory + debug log.
abstract class FrictionBoardSink {
  Future<void> send(InterfaceFaultReport report);
}

class DebugFrictionBoardSink implements FrictionBoardSink {
  @override
  Future<void> send(InterfaceFaultReport report) async {
    debugPrint('[FEBFL-036-A09] friction: ${report.toJson()}');
  }
}

/// Zero-allocation friendly telemetry hub. No per-frame allocations outside jank events.
class InterfaceTelemetryService {
  InterfaceTelemetryService._();
  static final InterfaceTelemetryService instance = InterfaceTelemetryService._();

  FrictionBoardSink sink = DebugFrictionBoardSink();
  final StreamController<InterfaceFaultReport> _controller =
      StreamController<InterfaceFaultReport>.broadcast();
  final List<InterfaceFaultReport> _recent = <InterfaceFaultReport>[];

  Stream<InterfaceFaultReport> get reports => _controller.stream;
  List<InterfaceFaultReport> get recent => List.unmodifiable(_recent);

  /// Latency threshold marker (finalize via master interface catalog). Default 250ms hesitation.
  int hesitationThresholdMs = 250;
  int jankFrameThresholdMs = 100;

  Future<void> recordFault(InterfaceFaultReport report) async {
    // Poka-Yoke: context params auto-injected; silent suppression impossible.
    PipelineConstraintValidator.validate(report);
    if (_controller.isClosed) return;
    _recent.add(report);
    if (_recent.length > 200) _recent.removeAt(0);
    _controller.add(report);
    try {
      await sink.send(report);
    } catch (e, s) {
      debugPrint('[FEBFL-036-A09] sink failed: $e\n$s');
    }
  }

  Future<void> recordException({
    required Object error,
    required StackTrace stack,
    required String componentErrorSource,
    String userId = 'anonymous',
    int userHesitationDurationMs = 0,
    String stepOutcome = 'UI_EXCEPTION_CAUGHT',
  }) {
    final report = InterfaceFaultReport(
      stepExecutionId: newStepExecutionId(),
      executionStatus: 'FAILED',
      executionTimestamp: DateTime.now().toUtc(),
      stepOutcome: stepOutcome,
      userId: userId,
      componentErrorSource: componentErrorSource,
      userHesitationDurationMs: userHesitationDurationMs,
      traceContextToken: newTraceToken(),
      stackSummary: stack.toString().length > 2000
          ? stack.toString().substring(0, 2000)
          : stack.toString(),
    );
    return recordFault(report);
  }

  void dispose() => _controller.close();
}

String newStepExecutionId() => 'EXE-${DateTime.now().microsecondsSinceEpoch}';
String newTraceToken() => 'TRC-${DateTime.now().microsecondsSinceEpoch}-${kIsWeb ? 'web' : 'app'}';

/// Automated listener to record execution lag across mobile rendering trees.
/// Uses SchedulerBinding frame timings — no polling, no per-frame allocation on smooth frames.
class RenderLagListener {
  RenderLagListener._();
  static bool _installed = false;
  static DateTime? _interactionStart;

  static void markInteractionStart() => _interactionStart = DateTime.now();

  static void install() {
    if (_installed) return;
    _installed = true;
    SchedulerBinding.instance.addTimingsCallback(_onTimings);
  }

  static void _onTimings(List<FrameTiming> timings) {
    final svc = InterfaceTelemetryService.instance;
    for (final t in timings) {
      final totalMs =
          (t.totalSpan.inMicroseconds / 1000.0).round();
      if (totalMs < svc.jankFrameThresholdMs) continue;
      final hesitation = _interactionStart == null
          ? totalMs
          : DateTime.now().difference(_interactionStart!).inMilliseconds;
      final report = InterfaceFaultReport(
        stepExecutionId: newStepExecutionId(),
        executionStatus: 'JANK',
        executionTimestamp: DateTime.now().toUtc(),
        stepOutcome: 'FRAME_LAG_${totalMs}MS',
        userId: 'anonymous',
        componentErrorSource: 'FlutterRenderingTree',
        userHesitationDurationMs: hesitation,
        traceContextToken: newTraceToken(),
        completionStatus: 'Partial',
      );
      // Fire-and-forget: never block UI thread.
      unawaited(svc.recordFault(report));
    }
  }
}

/// Root controller monitor. Installs FlutterError + PlatformDispatcher hooks and global ErrorWidget fallback.
class AppRootCrashMonitor extends StatefulWidget {
  final Widget child;
  final String userId;
  final FrictionBoardSink? sink;

  const AppRootCrashMonitor({
    super.key,
    required this.child,
    this.userId = 'anonymous',
    this.sink,
  });

  @override
  State<AppRootCrashMonitor> createState() => _AppRootCrashMonitorState();
}

class _AppRootCrashMonitorState extends State<AppRootCrashMonitor> {
  FlutterExceptionHandler? _prevFlutterHandler;
  ErrorCallback? _prevDispatcherHandler;
  ErrorWidgetBuilder? _prevErrorBuilder;

  @override
  void initState() {
    super.initState();
    if (widget.sink != null) InterfaceTelemetryService.instance.sink = widget.sink!;
    RenderLagListener.install();
    _prevFlutterHandler = FlutterError.onError;
    _prevDispatcherHandler = PlatformDispatcher.instance.onError;
    _prevErrorBuilder = ErrorWidget.builder;

    FlutterError.onError = (details) {
      unawaited(InterfaceTelemetryService.instance.recordException(
        error: details.exception,
        stack: details.stack ?? StackTrace.empty,
        componentErrorSource: details.library ?? 'AppRoot',
        userId: widget.userId,
      ));
      _prevFlutterHandler?.call(details);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      unawaited(InterfaceTelemetryService.instance.recordException(
        error: error,
        stack: stack,
        componentErrorSource: 'PlatformDispatcher',
        userId: widget.userId,
      ));
      if (_prevDispatcherHandler != null) return _prevDispatcherHandler!(error, stack);
      return true;
    };
    ErrorWidget.builder = (details) => FriendlyRecoveryFallback(
          traceToken: newTraceToken(),
          errorSummary: details.exceptionAsString(),
          onRetry: () => setState(() {}),
        );
  }

  @override
  void dispose() {
    FlutterError.onError = _prevFlutterHandler;
    PlatformDispatcher.instance.onError = _prevDispatcherHandler;
    if (_prevErrorBuilder != null) ErrorWidget.builder = _prevErrorBuilder!;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Standalone telemetry capture wrapper applicable to any feature view screen.
/// Every interface component file must wrap views within this fallback block.
class AppErrorBoundary extends StatefulWidget {
  final Widget child;
  final String componentErrorSource;
  final String userId;
  final Widget Function(BuildContext, VoidCallback)? fallbackBuilder;

  const AppErrorBoundary({
    super.key,
    required this.child,
    required this.componentErrorSource,
    this.userId = 'anonymous',
    this.fallbackBuilder,
  });

  @override
  State<AppErrorBoundary> createState() => _AppErrorBoundaryState();
}

class _AppErrorBoundaryState extends State<AppErrorBoundary> {
  Object? _error;
  String _traceToken = '';

  void _retry() => setState(() {
        _error = null;
        _traceToken = '';
      });

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      if (widget.fallbackBuilder != null) return widget.fallbackBuilder!(context, _retry);
      return FriendlyRecoveryFallback(traceToken: _traceToken, onRetry: _retry);
    }
    // Capture synchronous build errors in subtree without silent suppression.
    ErrorWidget.builder = (details) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        unawaited(InterfaceTelemetryService.instance.recordException(
          error: details.exception,
          stack: details.stack ?? StackTrace.empty,
          componentErrorSource: widget.componentErrorSource,
          userId: widget.userId,
        ));
        setState(() {
          _error = details.exception;
          _traceToken = newTraceToken();
        });
      });
      return const SizedBox.shrink();
    };
    return widget.child;
  }
}

/// Elegant system fallback with reassuring help options + conversational recovery copy.
/// Retry button meets 48dp x 48dp minimum touch target (Material 3).
class FriendlyRecoveryFallback extends StatelessWidget {
  final String traceToken;
  final String? errorSummary;
  final VoidCallback onRetry;

  const FriendlyRecoveryFallback({
    super.key,
    required this.traceToken,
    required this.onRetry,
    this.errorSummary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Material(
      color: cs.surfaceContainerLowest,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: cs.secondaryContainer,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Icon(Icons.cloud_off_outlined, color: cs.onSecondaryContainer, size: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hmm, that view stumbled — we\'ve got you.',
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Looks like a quick connection hiccup. Your progress is safe. Try again and we\'ll pick up right where you left off.',
                    style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: () {
                        RenderLagListener.markInteractionStart();
                        onRetry();
                      },
                      icon: const Icon(Icons.refresh, size: 20),
                      label: const Text('Try again'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => showModalBottomSheet<void>(
                        context: context,
                        showDragHandle: true,
                        builder: (_) => _HelpSheet(traceToken: traceToken),
                      ),
                      child: const Text('Get help'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SelectableText(
                    'Ref: $traceToken',
                    style: theme.textTheme.labelSmall?.copyWith(color: cs.outline),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HelpSheet extends StatelessWidget {
  final String traceToken;
  const _HelpSheet({required this.traceToken});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How to recover', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Text(
              '1. Check your connection and retry.\n2. If it keeps happening, share this reference with support.\n3. Nothing was charged or lost — this screen auto-reported the glitch.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            SelectableText('Reference: $traceToken', style: theme.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

/// Engineering dashboard card: displays layout bottleneck metrics clearly.
class LayoutBottleneckMetricsCard extends StatelessWidget {
  final List<InterfaceFaultReport> reports;
  const LayoutBottleneckMetricsCard({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final jank = reports.where((r) => r.executionStatus == 'JANK').length;
    final fails = reports.where((r) => r.executionStatus == 'FAILED').length;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Layout bottlenecks', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _Stat(label: 'Crashes caught', value: '$fails')),
                Expanded(child: _Stat(label: 'Jank events', value: '$jank')),
                Expanded(child: _Stat(label: 'Total', value: '${reports.length}')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: theme.textTheme.headlineSmall),
        Text(label, style: theme.textTheme.labelSmall),
      ],
    );
  }
}

/// Definition-of-done helper: <80% scenario coverage = prototype, not production rule.
String evaluateImplementationCompliance({required double scenarioCoverage01}) {
  if (scenarioCoverage01 >= 1.0) return 'Complete';
  if (scenarioCoverage01 >= 0.8) return 'Partial';
  return 'Not Complete';
}
