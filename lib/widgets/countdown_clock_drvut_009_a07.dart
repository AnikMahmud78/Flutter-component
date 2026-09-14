// DRVUT-009-A07 — High-Visibility 5-Minute Countdown Clock with Expiration Event Handling.
// Anchors frame-level ticks to Flutter's Ticker engine (equivalent to requestAnimationFrame),
// maintaining wall-clock synchronization, responsive Material 3 typography, and firing execution events at zero.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Telemetry payload emitted when the countdown completes or expires.
class CountdownExpirationEvent {
  const CountdownExpirationEvent({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.elapsedDuration,
  });

  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final Duration elapsedDuration;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'stepExecutionId': stepExecutionId,
        'executionStatus': executionStatus,
        'executionTimestamp': executionTimestamp.toIso8601String(),
        'stepOutcome': stepOutcome,
        'userId': userId,
        'elapsedDurationMs': elapsedDuration.inMilliseconds,
      };
}

/// High-visibility 5-minute countdown clock anchored to frame callbacks.
class CountdownClock extends StatefulWidget {
  const CountdownClock({
    super.key,
    this.maxDuration = const Duration(seconds: 300),
    this.userId = 'system-user',
    this.stepExecutionId = 'DRVUT-009-A07',
    this.onExpired,
    this.onTick,
    this.warningThreshold = const Duration(seconds: 60),
    this.criticalThreshold = const Duration(seconds: 15),
    this.showMilliseconds = true,
    this.autostart = true,
  }) : assert(maxDuration <= const Duration(seconds: 300),
            'Maximum boundary cannot exceed 300 seconds.');

  final Duration maxDuration;
  final String userId;
  final String stepExecutionId;
  final ValueChanged<CountdownExpirationEvent>? onExpired;
  final ValueChanged<Duration>? onTick;
  final Duration warningThreshold;
  final Duration criticalThreshold;
  final bool showMilliseconds;
  final bool autostart;

  @override
  State<CountdownClock> createState() => _CountdownClockState();
}

class _CountdownClockState extends State<CountdownClock>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late Ticker _ticker;
  late DateTime _targetTime;
  late DateTime _startTime;
  Duration _remaining = Duration.zero;
  bool _isExpired = false;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _remaining = widget.maxDuration;
    _ticker = createTicker(_onTickFrame);

    if (widget.autostart) {
      startCountdown();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Recalibrate against wall-clock when returning from background
    if (state == AppLifecycleState.resumed && _isRunning && !_isExpired) {
      _updateRemainingTime();
    }
  }

  /// Initiates or restarts the countdown clock anchored to wall-clock time.
  void startCountdown() {
    _startTime = DateTime.now();
    _targetTime = _startTime.add(_remaining);
    _isExpired = false;
    _isRunning = true;
    if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  /// Pauses active frame ticks.
  void pauseCountdown() {
    if (_isRunning) {
      _ticker.stop();
      setState(() {
        _isRunning = false;
      });
    }
  }

  /// Resets back to boundary limits.
  void resetCountdown() {
    _ticker.stop();
    setState(() {
      _remaining = widget.maxDuration;
      _isExpired = false;
      _isRunning = false;
    });
  }

  void _onTickFrame(Duration elapsed) {
    if (!_isRunning || _isExpired) return;
    _updateRemainingTime();
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    final difference = _targetTime.difference(now);

    if (difference <= Duration.zero) {
      _ticker.stop();
      setState(() {
        _remaining = Duration.zero;
        _isExpired = true;
        _isRunning = false;
      });

      final event = CountdownExpirationEvent(
        stepExecutionId: widget.stepExecutionId,
        executionStatus: 'EXPIRED',
        executionTimestamp: now,
        stepOutcome: 'Zero boundary reached. Automated lock initiated.',
        userId: widget.userId,
        elapsedDuration: widget.maxDuration,
      );
      widget.onExpired?.call(event);
    } else {
      setState(() {
        _remaining = difference;
      });
      widget.onTick?.call(_remaining);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker.dispose();
    super.dispose();
  }

  Color _resolveColor(ThemeData theme) {
    if (_isExpired) {
      return theme.colorScheme.error;
    }
    if (_remaining <= widget.criticalThreshold) {
      return theme.colorScheme.error;
    }
    if (_remaining <= widget.warningThreshold) {
      return theme.colorScheme.tertiary;
    }
    return theme.colorScheme.primary;
  }

  String _formatDisplayTime(Duration duration) {
    final totalSeconds = duration.inSeconds;
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');

    if (widget.showMilliseconds) {
      final ms = ((duration.inMilliseconds % 1000) ~/ 10)
          .toString()
          .padLeft(2, '0');
      return '$minutes:$seconds.$ms';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = _resolveColor(theme);
    final formattedTime = _formatDisplayTime(_remaining);
    final progress =
        (_remaining.inMilliseconds / widget.maxDuration.inMilliseconds)
            .clamp(0.0, 1.0);

    return Semantics(
      liveRegion: true,
      label: _isExpired
          ? 'Countdown expired. Action timing barrier enforced.'
          : 'Countdown timer: $formattedTime remaining.',
      child: Card(
        elevation: _isExpired ? 0 : 2,
        color: _isExpired
            ? theme.colorScheme.errorContainer
            : theme.colorScheme.surfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: activeColor.withOpacity(0.4),
            width: _isExpired ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        _isExpired
                            ? Icons.timer_off_rounded
                            : Icons.timer_outlined,
                        color: activeColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isExpired ? 'EXPIRED' : 'SESSION TIMEOUT',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: activeColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: activeColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: activeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  formattedTime,
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: activeColor,
                    fontWeight: FontWeight.w800,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: activeColor.withOpacity(0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(activeColor),
                  minHeight: 6,
                ),
              ),
              if (_isExpired) ...[
                const SizedBox(height: 12),
                Text(
                  'Strict timing barrier reached. Manual submission disabled.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
