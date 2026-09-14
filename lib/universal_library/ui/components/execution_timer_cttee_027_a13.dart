// CTTEE-027-A13 — Execution Timer Component for Micro-Task Screens.
// Provides an un-bypassable, high-contrast countdown clock with automated timeout trigger,
// physical field-locking wipe animation, and decoupled task ticket escalation reporting.

import 'dart:async';
import 'package:flutter/material.dart';

/// Audit payload dispatched when a micro-task times out or updates lifecycle state.
@immutable
class ExecutionTimerAuditRecord {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final Duration remainingDuration;

  const ExecutionTimerAuditRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.remainingDuration,
  });

  Map<String, dynamic> toJson() => {
        'stepExecutionId': stepExecutionId,
        'executionStatus': executionStatus,
        'executionTimestamp': executionTimestamp.toIso8601String(),
        'stepOutcome': stepOutcome,
        'userId': userId,
        'remainingSeconds': remainingDuration.inSeconds,
      };
}

/// Micro-task execution timer widget that enforces non-pausable constraints
/// and triggers automatic field locking / screen-wipe animation upon reaching 0:00.
class ExecutionTimerCttee027A13 extends StatefulWidget {
  final String stepExecutionId;
  final String userId;
  final Duration totalDuration;
  final VoidCallback? onTimeExpired;
  final ValueChanged<ExecutionTimerAuditRecord>? onEscalationTriggered;
  final Widget child;

  const ExecutionTimerCttee027A13({
    super.key,
    required this.stepExecutionId,
    required this.userId,
    this.totalDuration = const Duration(minutes: 5),
    this.onTimeExpired,
    this.onEscalationTriggered,
    required this.child,
  });

  @override
  State<ExecutionTimerCttee027A13> createState() =>
      _ExecutionTimerCttee027A13State();
}

class _ExecutionTimerCttee027A13State extends State<ExecutionTimerCttee027A13>
    with SingleTickerProviderStateMixin {
  late Duration _remainingTime;
  Timer? _ticker;
  bool _isExpired = false;
  late final AnimationController _wipeAnimationController;
  late final Animation<double> _wipeAnimation;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.totalDuration;

    _wipeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 650),
      vsync: this,
    );

    _wipeAnimation = CurvedAnimation(
      parent: _wipeAnimationController,
      curve: Curves.easeInOutQuart,
    );

    _startUnbypassableTimer();
  }

  void _startUnbypassableTimer() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_remainingTime.inSeconds <= 1) {
        timer.cancel();
        _handleTimeout();
      } else {
        setState(() {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        });
      }
    });
  }

  void _handleTimeout() {
    setState(() {
      _remainingTime = Duration.zero;
      _isExpired = true;
    });

    _wipeAnimationController.forward();

    final record = ExecutionTimerAuditRecord(
      stepExecutionId: widget.stepExecutionId,
      executionStatus: 'BREACHED',
      executionTimestamp: DateTime.now().toUtc(),
      stepOutcome: 'Fail',
      userId: widget.userId,
      remainingDuration: Duration.zero,
    );

    widget.onEscalationTriggered?.call(record);
    widget.onTimeExpired?.call();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _wipeAnimationController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCritical = _remainingTime.inSeconds <= 60 && !_isExpired;

    final Color badgeBgColor = _isExpired
        ? theme.colorScheme.errorContainer
        : (isCritical
            ? theme.colorScheme.error
            : theme.colorScheme.primaryContainer);

    final Color badgeFgColor = _isExpired
        ? theme.colorScheme.onErrorContainer
        : (isCritical
            ? theme.colorScheme.onError
            : theme.colorScheme.onPrimaryContainer);

    return Stack(
      children: [
        // Underlying task screen content — locked programmatically upon expiration
        AbsorbPointer(
          absorbing: _isExpired,
          child: widget.child,
        ),

        // Screen Wiping Curtain Animation (Poka-Yoke screen lock)
        AnimatedBuilder(
          animation: _wipeAnimation,
          builder: (context, child) {
            if (_wipeAnimation.value == 0.0) return const SizedBox.shrink();
            return Positioned.fill(
              child: ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _wipeAnimation.value,
                  child: Container(
                    color: theme.colorScheme.surface.withValues(alpha: 0.94),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_clock_outlined,
                          size: 56,
                          color: theme.colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Task Window Expired',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Token canceled at 0:00. This ticket has been automatically escalated.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Un-bypassable high-contrast visual clock badge
        Positioned(
          top: 12,
          right: 12,
          child: SafeArea(
            child: Semantics(
              label: 'Execution Countdown Timer',
              value: _formatDuration(_remainingTime),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isExpired
                          ? Icons.timer_off
                          : (isCritical
                              ? Icons.alarm_on
                              : Icons.timer_outlined),
                      size: 18,
                      color: badgeFgColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDuration(_remainingTime),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: badgeFgColor,
                        fontWeight: FontWeight.w800,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
