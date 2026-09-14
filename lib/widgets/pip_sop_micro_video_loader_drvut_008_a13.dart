// DRVUT-008-A13 — Picture-in-Picture Under-60s Task SOP Micro-Video Loader.
// Renders a responsive Material 3 Picture-in-Picture SOP micro-learning overlay with strict 60-second limit
// validation, auto-start playback, input freezing blockers, and telemetry reporting.

import 'dart:async';
import 'package:flutter/material.dart';

/// Telemetry record emitted upon SOP video playback events and completion.
class SopPlaybackTelemetry {
  final String testType;
  final String testResult;
  final double testCoverage;
  final DateTime testTimestamp;
  final String testLogPath;
  final String userSessionId;
  final Duration elapsed;
  final Duration totalDuration;
  final bool isCompleted;

  const SopPlaybackTelemetry({
    required this.testType,
    required this.testResult,
    required this.testCoverage,
    required this.testTimestamp,
    required this.testLogPath,
    required this.userSessionId,
    required this.elapsed,
    required this.totalDuration,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() => {
        'testType': testType,
        'testResult': testResult,
        'testCoverage': testCoverage,
        'testTimestamp': testTimestamp.toIso8601String(),
        'testLogPath': testLogPath,
        'userSessionId': userSessionId,
        'elapsedMs': elapsed.inMilliseconds,
        'totalDurationMs': totalDuration.inMilliseconds,
        'isCompleted': isCompleted,
      };
}

/// Controller to coordinate SOP video playback, input blockers, and time limits.
class SopVideoController extends ChangeNotifier {
  final String tutorialLocationCode;
  final Duration maxAllowedDuration;
  final Duration videoDuration;
  final String sessionId;

  Timer? _playbackTimer;
  Duration _currentPosition = Duration.zero;
  bool _isPlaying = false;
  bool _isCompleted = false;
  bool _isRejected = false;
  String? _rejectionReason;

  Duration get currentPosition => _currentPosition;
  bool get isPlaying => _isPlaying;
  bool get isCompleted => _isCompleted;
  bool get isRejected => _isRejected;
  String? get rejectionReason => _rejectionReason;
  double get progress => videoDuration.inMilliseconds > 0
      ? (_currentPosition.inMilliseconds / videoDuration.inMilliseconds).clamp(0.0, 1.0)
      : 0.0;

  SopVideoController({
    required this.tutorialLocationCode,
    this.maxAllowedDuration = const Duration(seconds: 60),
    required this.videoDuration,
    required this.sessionId,
  }) {
    _validateDuration();
  }

  void _validateDuration() {
    if (videoDuration > maxAllowedDuration) {
      _isRejected = true;
      _rejectionReason =
          'Poka-Yoke Violation: SOP media exceeds max permitted duration of ${maxAllowedDuration.inSeconds}s.';
    }
  }

  void initializeAndPlay({VoidCallback? onCompleted}) {
    if (_isRejected || _isPlaying || _isCompleted) return;

    _isPlaying = true;
    notifyListeners();

    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      final nextMs = _currentPosition.inMilliseconds + 250;
      if (nextMs >= videoDuration.inMilliseconds) {
        _currentPosition = videoDuration;
        _isPlaying = false;
        _isCompleted = true;
        timer.cancel();
        notifyListeners();
        if (onCompleted != null) {
          onCompleted();
        }
      } else {
        _currentPosition = Duration(milliseconds: nextMs);
        notifyListeners();
      }
    });
  }

  void pause() {
    if (!_isPlaying) return;
    _isPlaying = false;
    _playbackTimer?.cancel();
    notifyListeners();
  }

  void restart({VoidCallback? onCompleted}) {
    _playbackTimer?.cancel();
    _currentPosition = Duration.zero;
    _isCompleted = false;
    initializeAndPlay(onCompleted: onCompleted);
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    super.dispose();
  }
}

/// Picture-in-Picture Under-60s Task SOP Micro-Video Loader component.
/// Provides auto-initialization, floating/docked responsive PiP presentation,
/// and freezes guarded form fields/inputs until SOP playback fully completes.
class PipSopMicroVideoLoader extends StatefulWidget {
  final String cloudStorageTutorialUri;
  final Duration videoDuration;
  final String sessionId;
  final Widget child;
  final ValueChanged<SopPlaybackTelemetry>? onTelemetryEmitted;
  final VoidCallback? onCompletionUnlocked;
  final bool autoStart;
  final double pipAspectRatio;

  const PipSopMicroVideoLoader({
    super.key,
    required this.cloudStorageTutorialUri,
    required this.videoDuration,
    required this.sessionId,
    required this.child,
    this.onTelemetryEmitted,
    this.onCompletionUnlocked,
    this.autoStart = true,
    this.pipAspectRatio = 16 / 9,
  });

  @override
  State<PipSopMicroVideoLoader> createState() => _PipSopMicroVideoLoaderState();
}

class _PipSopMicroVideoLoaderState extends State<PipSopMicroVideoLoader> {
  late final SopVideoController _controller;
  bool _isMinimized = false;
  Offset _pipPosition = const Offset(16.0, 16.0);

  @override
  void initState() {
    super.initState();
    _controller = SopVideoController(
      tutorialLocationCode: widget.cloudStorageTutorialUri,
      videoDuration: widget.videoDuration,
      sessionId: widget.sessionId,
    );

    _controller.addListener(_handleStateChange);

    if (widget.autoStart && !_controller.isRejected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.initializeAndPlay(onCompleted: _handleCompleted);
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleStateChange);
    _controller.dispose();
    super.dispose();
  }

  void _handleStateChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleCompleted() {
    final telemetry = SopPlaybackTelemetry(
      testType: 'SOP_MICRO_VIDEO_STREAM',
      testResult: _controller.isCompleted ? 'Pass' : 'Fail',
      testCoverage: 100.0,
      testTimestamp: DateTime.now().toUtc(),
      testLogPath: 'cloud_storage://logs/sop_${widget.sessionId}.log',
      userSessionId: widget.sessionId,
      elapsed: _controller.currentPosition,
      totalDuration: _controller.videoDuration,
      isCompleted: _controller.isCompleted,
    );

    widget.onTelemetryEmitted?.call(telemetry);
    widget.onCompletionUnlocked?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBlocked = !_controller.isCompleted && !_controller.isRejected;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final pipWidth = (screenWidth * 0.46).clamp(160.0, 240.0);
        final pipHeight = pipWidth / widget.pipAspectRatio;

        return Stack(
          children: [
            // Core Workspace Form Content — Frozen via AbsorbPointer when SOP is incomplete
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: isBlocked,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: isBlocked ? 0.62 : 1.0,
                  child: widget.child,
                ),
              ),
            ),

            // Top Notification Bar when inputs are frozen
            if (isBlocked)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  elevation: 2,
                  color: theme.colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_clock_outlined,
                          size: 18,
                          color: theme.colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Workspace locked: Complete mandatory SOP micro-video to unlock inputs.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onErrorContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Floating Minimalist Picture-in-Picture Overlay
            Positioned(
              right: _pipPosition.dx,
              bottom: _pipPosition.dy,
              child: _buildPipContainer(theme, pipWidth, pipHeight),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPipContainer(ThemeData theme, double width, double height) {
    if (_controller.isRejected) {
      return Container(
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.error),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: theme.colorScheme.error, size: 24),
            const SizedBox(height: 6),
            Text(
              _controller.rejectionReason ?? 'Media Rejected',
              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onErrorContainer),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _controller.isCompleted
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
          width: 1.5,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: _isMinimized ? 44 : height + 36,
        color: theme.colorScheme.surfaceContainerHighest,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Bar with Compact Controls
            Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              color: theme.colorScheme.surface,
              child: Row(
                children: [
                  Icon(
                    _controller.isCompleted
                        ? Icons.check_circle
                        : Icons.play_circle_fill,
                    size: 16,
                    color: _controller.isCompleted
                        ? theme.colorScheme.primary
                        : theme.colorScheme.secondary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'SOP Tutorial',
                      style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 18,
                    icon: Icon(_isMinimized ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                    onPressed: () => setState(() => _isMinimized = !_isMinimized),
                  ),
                ],
              ),
            ),

            // Media Viewport
            if (!_isMinimized)
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: Colors.black87,
                      child: Center(
                        child: Icon(
                          Icons.ondemand_video,
                          color: Colors.white70,
                          size: 32,
                        ),
                      ),
                    ),
                    // Progress Indicator Layer
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${_controller.currentPosition.inSeconds}s',
                                  style: const TextStyle(color: Colors.white, fontSize: 10),
                                ),
                                Text(
                                  '${_controller.videoDuration.inSeconds}s',
                                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          LinearProgressIndicator(
                            value: _controller.progress,
                            minHeight: 4,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
