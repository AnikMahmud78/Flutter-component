// DRVUT-008-A10 — Picture-in-Picture Under-60s Task SOP Micro-Video Loader.
// Implements a draggable floating PiP overlay for under-60-second task SOP instructions
// with drag gestures, workspace boundary clamping, completion tracking, and execution blocker controls.

import 'dart:async';
import 'package:flutter/material.dart';

/// Telemetry event payload recorded for analytics and verification pipelines.
class PipTaskSopTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final DateTime executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus; // 'Pass' or 'Fail'
  final double totalDurationSeconds;

  const PipTaskSopTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.totalDurationSeconds,
  });

  Map<String, dynamic> toJson() => {
    'stepExecutionId': stepExecutionId,
    'executionStatus': executionStatus,
    'executionTimestamp': executionTimestamp.toIso8601String(),
    'stepOutcome': stepOutcome,
    'userId': userId,
    'completionStatus': completionStatus,
    'totalDurationSeconds': totalDurationSeconds,
  };
}

/// Picture-in-Picture Micro-Video Loader with drag gestures and execution blocker.
class PipTaskSopVideoLoader extends StatefulWidget {
  final String stepExecutionId;
  final String userId;
  final String videoUrl;
  final double videoDurationSeconds;
  final Widget child; // Underlying workspace content that may be frozen/blocked
  final ValueChanged<PipTaskSopTelemetry>? onCompletionLogged;
  final VoidCallback? onPlaybackCompleted;

  const PipTaskSopVideoLoader({
    super.key,
    required this.stepExecutionId,
    required this.userId,
    required this.videoUrl,
    this.videoDurationSeconds = 45.0,
    required this.child,
    this.onCompletionLogged,
    this.onPlaybackCompleted,
  }) : assert(videoDurationSeconds <= 60.0, 'Poka-Yoke: Video duration must not exceed 60 seconds.');

  @override
  State<PipTaskSopVideoLoader> createState() => _PipTaskSopVideoLoaderState();
}

class _PipTaskSopVideoLoaderState extends State<PipTaskSopVideoLoader> {
  static const double _pipWidth = 260.0;
  static const double _pipHeight = 150.0;
  static const double _screenPadding = 16.0;

  Offset? _pipOffset;
  bool _isDragging = false;
  bool _isPlaying = false;
  bool _isCompleted = false;
  double _playbackSeconds = 0.0;
  Timer? _playbackTimer;

  @override
  void initState() {
    super.initState();
    // Automated initialization: start streaming/playback on first view
    _startPlayback();
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    super.dispose();
  }

  void _startPlayback() {
    setState(() {
      _isPlaying = true;
    });
    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (!mounted) return;
      setState(() {
        _playbackSeconds += 0.2;
        if (_playbackSeconds >= widget.videoDurationSeconds) {
          _playbackSeconds = widget.videoDurationSeconds;
          _handleVideoFinished();
        }
      });
    });
  }

  void _togglePlayPause() {
    if (_isCompleted) {
      setState(() {
        _playbackSeconds = 0.0;
        _isCompleted = false;
      });
      _startPlayback();
      return;
    }
    if (_isPlaying) {
      _playbackTimer?.cancel();
      setState(() => _isPlaying = false);
    } else {
      _startPlayback();
    }
  }

  void _handleVideoFinished() {
    _playbackTimer?.cancel();
    _isPlaying = false;
    _isCompleted = true;

    final telemetry = PipTaskSopTelemetry(
      stepExecutionId: widget.stepExecutionId,
      executionStatus: 'COMPLETED',
      executionTimestamp: DateTime.now().toUtc(),
      stepOutcome: 'Under-60s SOP watched in full',
      userId: widget.userId,
      completionStatus: 'Pass',
      totalDurationSeconds: widget.videoDurationSeconds,
    );

    widget.onCompletionLogged?.call(telemetry);
    widget.onPlaybackCompleted?.call();
  }

  void _updatePosition(Offset delta, Size parentSize) {
    final current = _pipOffset ?? Offset(parentSize.width - _pipWidth - _screenPadding, parentSize.height - _pipHeight - _screenPadding);
    final nextX = (current.dx + delta.dx).clamp(_screenPadding, parentSize.width - _pipWidth - _screenPadding);
    final nextY = (current.dy + delta.dy).clamp(_screenPadding, parentSize.height - _pipHeight - _screenPadding);

    setState(() {
      _pipOffset = Offset(nextX, nextY);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final parentSize = Size(constraints.maxWidth, constraints.maxHeight);
        final currentOffset = _pipOffset ?? Offset(
          parentSize.width - _pipWidth - _screenPadding,
          parentSize.height - _pipHeight - _screenPadding,
        );

        return Stack(
          children: [
            // Underlying workspace content with execution blocker (disabled until complete)
            AbsorbPointer(
              absorbing: !_isCompleted,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isCompleted ? 1.0 : 0.65,
                child: widget.child,
              ),
            ),

            // Floating Draggable Picture-in-Picture window
            Positioned(
              left: currentOffset.dx,
              top: currentOffset.dy,
              child: GestureDetector(
                onPanStart: (_) => setState(() => _isDragging = true),
                onPanUpdate: (details) => _updatePosition(details.delta, parentSize),
                onPanEnd: (_) => setState(() => _isDragging = false),
                child: Material(
                  elevation: _isDragging ? 12 : 6,
                  borderRadius: BorderRadius.circular(12.0),
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Container(
                    width: _pipWidth,
                    height: _pipHeight,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: _isCompleted
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outlineVariant,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top header with drag indicator and SOP title
                        Row(
                          children: [
                            Icon(Icons.drag_indicator, size: 16, color: theme.colorScheme.onSurfaceVariant),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'SOP Video (${widget.videoDurationSeconds.toInt()}s Max)',
                                style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: _isCompleted ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _isCompleted ? 'Unlocked' : 'Input Locked',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: _isCompleted ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onErrorContainer,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Stream simulation display
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _isCompleted
                                      ? Icons.replay
                                      : (_isPlaying ? Icons.pause_circle : Icons.play_circle),
                                  size: 32,
                                  color: theme.colorScheme.primary,
                                ),
                                onPressed: _togglePlayPause,
                              ),
                              Text(
                                '${_playbackSeconds.toStringAsFixed(1)}s / ${widget.videoDurationSeconds.toStringAsFixed(0)}s',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // Progress bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: (_playbackSeconds / widget.videoDurationSeconds).clamp(0.0, 1.0),
                            minHeight: 6,
                            backgroundColor: theme.colorScheme.surfaceVariant,
                            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
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
      },
    );
  }
}
