// CTTEE-018-02 — Interactive Countdown Execution Clock Module
// Provides a visible real-time execution clock tracking component across task layouts.
// Features configurable alert latency thresholds, telemetry status updates, and full pause/resume controls.

import 'dart:async';
import 'package:flutter/material.dart';

/// Represents qualitative assessment status based on SLO golden signal thresholds.
enum ExecutionClockStatus {
  high,
  medium,
  low,
}

/// Telemetry payload emitted during clock lifecycle updates.
class ExecutionClockTelemetry {
  final String setupStepId;
  final String setupStatus;
  final Map<String, dynamic> setupConfiguration;
  final String validationResult;
  final DateTime setupCompletionTime;
  final String qualitativeRating;
  final Duration remainingDuration;

  const ExecutionClockTelemetry({
    required this.setupStepId,
    required this.setupStatus,
    required this.setupConfiguration,
    required this.validationResult,
    required this.setupCompletionTime,
    required this.qualitativeRating,
    required this.remainingDuration,
  });

  Map<String, dynamic> toJson() => {
    'setup_step_id': setupStepId,
    'setup_status': setupStatus,
    'setup_configuration': setupConfiguration,
    'validation_result': validationResult,
    'setup_completion_time': setupCompletionTime.toIso8601String(),
    'completion_status': qualitativeRating,
    'remaining_duration_ms': remainingDuration.inMilliseconds,
  };
}

/// Interactive countdown clock widget for task execution tracking.
class CountdownExecutionClock extends StatefulWidget {
  final String setupStepId;
  final Duration totalDuration;
  final Duration alertThreshold;
  final Duration warningThreshold;
  final ValueChanged<ExecutionClockTelemetry>? onTelemetryEmitted;
  final VoidCallback? onCompleted;
  final bool autoStart;

  const CountdownExecutionClock({
    super.key,
    this.setupStepId = 'CTTEE-018-02',
    this.totalDuration = const Duration(minutes: 25),
    this.alertThreshold = const Duration(minutes: 1),
    this.warningThreshold = const Duration(minutes: 5),
    this.onTelemetryEmitted,
    this.onCompleted,
    this.autoStart = true,
  });

  @override
  State<CountdownExecutionClock> createState() => _CountdownExecutionClockState();
}

class _CountdownExecutionClockState extends State<CountdownExecutionClock> {
  late Duration _remainingDuration;
  Timer? _timer;
  bool _isRunning = false;
  String _validationStatus = 'INITIALIZED';

  @override
  void initState() {
    super.initState();
    _remainingDuration = widget.totalDuration;
    if (widget.autoStart) {
      _startTimer();
    }
    _emitTelemetry('ACTIVE');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingDuration.inSeconds > 0) {
        setState(() {
          _remainingDuration -= const Duration(seconds: 1);
        });
        if (_remainingDuration.inSeconds % 30 == 0) {
          _emitTelemetry('RUNNING');
        }
      } else {
        _timer?.cancel();
        setState(() {
          _isRunning = false;
          _validationStatus = 'COMPLETED';
        });
        _emitTelemetry('COMPLETED');
        widget.onCompleted?.call();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
    _emitTelemetry('PAUSED');
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _remainingDuration = widget.totalDuration;
      _validationStatus = 'RESET';
    });
    _emitTelemetry('RESET');
  }

  ExecutionClockStatus _resolveStatus() {
    if (_remainingDuration <= widget.alertThreshold) {
      return ExecutionClockStatus.low;
    } else if (_remainingDuration <= widget.warningThreshold) {
      return ExecutionClockStatus.medium;
    }
    return ExecutionClockStatus.high;
  }

  String _getQualitativeLabel(ExecutionClockStatus status) {
    switch (status) {
      case ExecutionClockStatus.high:
        return 'High';
      case ExecutionClockStatus.medium:
        return 'Medium';
      case ExecutionClockStatus.low:
        return 'Low';
    }
  }

  void _emitTelemetry(String status) {
    final rating = _resolveStatus();
    final telemetry = ExecutionClockTelemetry(
      setupStepId: widget.setupStepId,
      setupStatus: status,
      setupConfiguration: {
        'total_duration_sec': widget.totalDuration.inSeconds,
        'warning_threshold_sec': widget.warningThreshold.inSeconds,
        'alert_threshold_sec': widget.alertThreshold.inSeconds,
        'floor_boundary': '95% cov. / <15 min',
        'optimal_target': '99% cov. / <5 min',
        'ceiling_boundary': '100% cov. / <1 min',
      },
      validationResult: _validationStatus,
      setupCompletionTime: DateTime.now().toUtc(),
      qualitativeRating: _getQualitativeLabel(rating),
      remainingDuration: _remainingDuration,
    );
    widget.onTelemetryEmitted?.call(telemetry);
  }

  Color _getIndicatorColor(ThemeData theme, ExecutionClockStatus status) {
    switch (status) {
      case ExecutionClockStatus.high:
        return theme.colorScheme.primary;
      case ExecutionClockStatus.medium:
        return Colors.amber.shade700;
      case ExecutionClockStatus.low:
        return theme.colorScheme.error;
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = _resolveStatus();
    final indicatorColor = _getIndicatorColor(theme, status);
    final progress = widget.totalDuration.inSeconds > 0
        ? (_remainingDuration.inSeconds / widget.totalDuration.inSeconds).clamp(0.0, 1.0)
        : 0.0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.timer_outlined, color: indicatorColor),
                    const SizedBox(width: 8),
                    Text(
                      'Execution Clock',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: indicatorColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: indicatorColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    'Health: ${_getQualitativeLabel(status)}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: indicatorColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatDuration(_remainingDuration),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    Text(
                      _isRunning ? 'RUNNING' : 'STOPPED',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filledTonal(
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  tooltip: _isRunning ? 'Pause execution' : 'Start execution',
                  onPressed: () {
                    if (_isRunning) {
                      _pauseTimer();
                    } else {
                      _startTimer();
                    }
                  },
                ),
                const SizedBox(width: 12),
                IconButton.outlined(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Reset timer',
                  onPressed: _resetTimer,
                ),
              ],
            ),
          ],
         Junta),
      ),
    );
  }
}
