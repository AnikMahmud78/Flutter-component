// CTTEE-003 — Micro-Task Timestamp Clock with SLA Visual Alerts.
// Provides an interactive duration monitoring gauge that animates a high-contrast flashing alert ring
// when micro-task execution breaches predefined SLA thresholds across responsive viewport classes.

import 'dart:async';
import 'package:flutter/material.dart';

enum SlaValidationStatus {
  healthy,
  warning,
  breached,
}

class MicroTaskDefinition {
  final String definitionId;
  final String definitionName;
  final String definitionType;
  final Map<String, dynamic> definitionParameters;
  final Duration slaThreshold;
  final Duration warningThreshold;

  const MicroTaskDefinition({
    required this.definitionId,
    required this.definitionName,
    required this.definitionType,
    required this.definitionParameters,
    required this.slaThreshold,
    this.warningThreshold = const Duration(seconds: 45),
  });
}

class MicroTaskTimestampClockCTTEE003 extends StatefulWidget {
  final MicroTaskDefinition taskDefinition;
  final DateTime? startedAt;
  final bool isRunning;
  final VoidCallback? onThresholdBreached;
  final VoidCallback? onReset;

  const MicroTaskTimestampClockCTTEE003({
    super.key,
    required this.taskDefinition,
    this.startedAt,
    this.isRunning = true,
    this.onThresholdBreached,
    this.onReset,
  });

  @override
  State<MicroTaskTimestampClockCTTEE003> createState() =>
      _MicroTaskTimestampClockCTTEE003State();
}

class _MicroTaskTimestampClockCTTEE003State
    extends State<MicroTaskTimestampClockCTTEE003>
    with SingleTickerProviderStateMixin {
  late AnimationController _flashController;
  late Animation<double> _flashAnimation;
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  bool _hasTriggeredBreachedCallback = false;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _flashAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _flashController, curve: Curves.easeInOut),
    );

    if (widget.isRunning) {
      _startTicker();
    }
  }

  @override
  void didUpdateWidget(covariant MicroTaskTimestampClockCTTEE003 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning != oldWidget.isRunning) {
      if (widget.isRunning) {
        _startTicker();
      } else {
        _ticker?.cancel();
      }
    }
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(milliseconds: 200), (_) {
      final now = DateTime.now();
      final start = widget.startedAt ?? now.subtract(_elapsed);
      final currentElapsed = now.difference(start);

      if (!mounted) return;
      setState(() {
        _elapsed = currentElapsed;
      });

      final status = _currentStatus;
      if (status == SlaValidationStatus.breached) {
        if (!_flashController.isAnimating) {
          _flashController.repeat(reverse: true);
        }
        if (!_hasTriggeredBreachedCallback) {
          _hasTriggeredBreachedCallback = true;
          widget.onThresholdBreached?.call();
        }
      } else {
        if (_flashController.isAnimating) {
          _flashController.stop();
          _flashController.reset();
        }
      }
    });
  }

  SlaValidationStatus get _currentStatus {
    if (_elapsed >= widget.taskDefinition.slaThreshold) {
      return SlaValidationStatus.breached;
    } else if (_elapsed >= widget.taskDefinition.warningThreshold) {
      return SlaValidationStatus.warning;
    }
    return SlaValidationStatus.healthy;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _flashController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final millis = (duration.inMilliseconds.remainder(1000) ~/ 100).toString();
    return '$minutes:$seconds.$millis';
  }

  Color _getStatusColor(ThemeData theme, SlaValidationStatus status) {
    switch (status) {
      case SlaValidationStatus.healthy:
        return theme.colorScheme.primary;
      case SlaValidationStatus.warning:
        return Colors.orangeAccent;
      case SlaValidationStatus.breached:
        return theme.colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = _currentStatus;
    final statusColor = _getStatusColor(theme, status);
    final progressRatio = (_elapsed.inMilliseconds /
            widget.taskDefinition.slaThreshold.inMilliseconds)
        .clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 420;

        return AnimatedBuilder(
          animation: _flashAnimation,
          builder: (context, child) {
            final flashOpacity = status == SlaValidationStatus.breached
                ? _flashAnimation.value
                : 0.0;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: status == SlaValidationStatus.breached
                      ? theme.colorScheme.error.withValues(alpha: flashOpacity)
                      : theme.colorScheme.outlineVariant,
                  width: status == SlaValidationStatus.breached ? 2.5 : 1.0,
                ),
                boxShadow: status == SlaValidationStatus.breached
                    ? [
                        BoxShadow(
                          color: theme.colorScheme.error.withValues(alpha: 0.3 * flashOpacity),
                          blurRadius: 16,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
              ),
              child: child,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(theme, status, statusColor),
              const SizedBox(height: 16),
              _buildGaugeSection(theme, status, statusColor, progressRatio, isCompact),
              const SizedBox(height: 12),
              _buildMetadataFooter(theme),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    ThemeData theme,
    SlaValidationStatus status,
    Color statusColor,
  ) {
    return Row(
      children: [
        Icon(
          status == SlaValidationStatus.breached
              ? Icons.warning_amber_rounded
              : Icons.timer_outlined,
          color: statusColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.taskDefinition.definitionName,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: statusColor, width: 1),
          ),
          child: Text(
            status.name.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGaugeSection(
    ThemeData theme,
    SlaValidationStatus status,
    Color statusColor,
    double progressRatio,
    bool isCompact,
  ) {
    final clockContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _formatDuration(_elapsed),
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontFeatures: const [FontFeature.tabularFigures()],
            color: status == SlaValidationStatus.breached
                ? theme.colorScheme.error
                : theme.colorScheme.onSurface,
          ),
        ),
        Text(
          'SLA: ${_formatDuration(widget.taskDefinition.slaThreshold)}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );

    final gaugeWidget = Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 130,
          height: 130,
          child: CircularProgressIndicator(
            value: progressRatio,
            strokeWidth: 8,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
        ),
        clockContent,
      ],
    );

    if (isCompact) {
      return Center(child: gaugeWidget);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        gaugeWidget,
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${widget.taskDefinition.definitionId}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Type: ${widget.taskDefinition.definitionType}',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progressRatio,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                minHeight: 6,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetadataFooter(ThemeData theme) {
    final paramCount = widget.taskDefinition.definitionParameters.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Parameters: $paramCount active',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (widget.onReset != null)
          TextButton.icon(
            onPressed: () {
              setState(() {
                _elapsed = Duration.zero;
                _hasTriggeredBreachedCallback = false;
              });
              _flashController.stop();
              _flashController.reset();
              widget.onReset?.call();
            },
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Reset'),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
      ],
    );
  }
}
