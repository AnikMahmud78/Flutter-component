// CTTEE-029 — On-Screen 5-Minute Timer Implementation with Sticky App Bar Placement.
// Implements a sticky app bar countdown timer widget featuring dynamic behavioral stress and urgency styling,
// Material 3 badges, and operational performance telemetry (Good / Average / Poor) aligned with Nielsen Norman Group heuristics.

import 'dart:async';
import 'package:flutter/material.dart';

/// Performance evaluation rating according to NNG response & task-timing heuristics.
enum TaskTimingRating {
  good,
  average,
  poor,
}

/// Extension to format [TaskTimingRating] qualitative label.
extension TaskTimingRatingExt on TaskTimingRating {
  String get label {
    switch (this) {
      case TaskTimingRating.good:
        return 'Good';
      case TaskTimingRating.average:
        return 'Average';
      case TaskTimingRating.poor:
        return 'Poor';
    }
  }
}

/// Telemetry payload emitted upon execution events or timer completion.
class TimerExecutionTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final TaskTimingRating completionStatus;
  final Duration elapsed;
  final Duration remaining;

  const TimerExecutionTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.elapsed,
    required this.remaining,
  });

  Map<String, dynamic> toMap() => {
        'stepExecutionId': stepExecutionId,
        'executionStatus': executionStatus,
        'executionTimestamp': executionTimestamp.toIso8601String(),
        'stepOutcome': stepOutcome,
        'userId': userId,
        'completionStatus': completionStatus.label,
        'elapsedSeconds': elapsed.inSeconds,
        'remainingSeconds': remaining.inSeconds,
      };
}

/// A sticky app bar widget embedding an on-screen 5-minute countdown timer.
/// Supports standard [PreferredSizeWidget] placement as well as sticky scroll integration.
class StickyAppBarTimerCttee029 extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String userId;
  final String stepExecutionId;
  final Duration targetDuration;
  final Duration floorBoundary;
  final Duration ceilingBoundary;
  final bool autoStart;
  final VoidCallback? onTimeout;
  final ValueChanged<TimerExecutionTelemetry>? onTelemetryEmitted;
  final List<Widget>? actions;
  final Widget? leading;

  const StickyAppBarTimerCttee029({
    super.key,
    this.title = 'Active Task Window',
    required this.userId,
    required this.stepExecutionId,
    this.targetDuration = const Duration(minutes: 5),
    this.floorBoundary = const Duration(minutes: 3),
    this.ceilingBoundary = const Duration(minutes: 10),
    this.autoStart = true,
    this.onTimeout,
    this.onTelemetryEmitted,
    this.actions,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48.0);

  @override
  State<StickyAppBarTimerCttee029> createState() => _StickyAppBarTimerCttee029State();
}

class _StickyAppBarTimerCttee029State extends State<StickyAppBarTimerCttee029>
    with SingleTickerProviderStateMixin {
  late int _remainingSeconds;
  late int _initialSeconds;
  Timer? _timer;
  bool _isRunning = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _initialSeconds = widget.targetDuration.inSeconds;
    _remainingSeconds = _initialSeconds;
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.88,
      upperBound: 1.0,
    );

    if (widget.autoStart) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning) return;
    _timer?.cancel();
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });

        // Activate pulsing alert animation when urgency threshold reached (< 60s)
        if (_remainingSeconds <= 60 && !_pulseController.isAnimating) {
          _pulseController.repeat(reverse: true);
        }
      } else {
        _timer?.cancel();
        _pulseController.stop();
        setState(() => _isRunning = false);
        _handleCompletion(outcome: 'TIMED_OUT', status: 'COMPLETED');
        widget.onTimeout?.call();
      }
    });
  }

  void _handleCompletion({
    required String outcome,
    required String status,
  }) {
    final rating = _resolveRating();
    final telemetry = TimerExecutionTelemetry(
      stepExecutionId: widget.stepExecutionId,
      executionStatus: status,
      executionTimestamp: DateTime.now().toUtc(),
      stepOutcome: outcome,
      userId: widget.userId,
      completionStatus: rating,
      elapsed: Duration(seconds: _initialSeconds - _remainingSeconds),
      remaining: Duration(seconds: _remainingSeconds),
    );
    widget.onTelemetryEmitted?.call(telemetry);
  }

  TaskTimingRating _resolveRating() {
    final elapsed = Duration(seconds: _initialSeconds - _remainingSeconds);
    if (elapsed <= widget.floorBoundary) {
      return TaskTimingRating.good;
    } else if (elapsed <= widget.targetDuration) {
      return TaskTimingRating.average;
    } else {
      return TaskTimingRating.poor;
    }
  }

  Color _getUrgencyColor(ThemeData theme) {
    if (_remainingSeconds <= 60) {
      return theme.colorScheme.error;
    } else if (_remainingSeconds <= widget.floorBoundary.inSeconds) {
      return Colors.orange.shade700;
    }
    return theme.colorScheme.primary;
  }

  String _formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final urgencyColor = _getUrgencyColor(theme);
    final rating = _resolveRating();
    final progress = (_initialSeconds > 0)
        ? (_remainingSeconds / _initialSeconds).clamp(0.0, 1.0)
        : 0.0;

    return Material(
      elevation: 3.0,
      color: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text(
                widget.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: widget.leading,
              centerTitle: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Badge(
                    backgroundColor: urgencyColor,
                    label: Text(
                      rating.label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onError,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (widget.actions != null) ...widget.actions!,
              ],
            ),
            // Sticky Timer Header Row with Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ScaleTransition(
                        scale: _remainingSeconds <= 60
                            ? _pulseController
                            : const AlwaysStoppedAnimation(1.0),
                        child: Icon(
                          Icons.timer_outlined,
                          size: 20.0,
                          color: urgencyColor,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        _formatDuration(_remainingSeconds),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: urgencyColor,
                          fontWeight: FontWeight.w700,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Optimal: ${widget.targetDuration.inMinutes}m',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Floor: ${widget.floorBoundary.inMinutes}m',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            LinearProgressIndicator(
              value: progress,
              minHeight: 3.5,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(urgencyColor),
            ),
          ],
        ),
      ),
    );
  }
}
