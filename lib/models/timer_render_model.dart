// lib/models/timer_render_model.dart
class TimerRenderModel {
  final int remainingSeconds;
  final double fpsTarget;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const TimerRenderModel({
    required this.remainingSeconds,
    required this.fpsTarget,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
