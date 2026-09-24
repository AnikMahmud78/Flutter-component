import 'package:flutter/foundation.dart';

enum PlaybackHealth { high, medium, low }

@immutable
class Video3gPlaybackModel {
  final String taskId;
  final String mediaUrl;
  final double startupLatencyMs;
  final double playbackSuccessRate;
  final PlaybackHealth health;
  final DateTime timestamp;
  final String sessionUser;

  const Video3gPlaybackModel({
    required this.taskId,
    required this.mediaUrl,
    required this.startupLatencyMs,
    required this.playbackSuccessRate,
    required this.health,
    required this.timestamp,
    required this.sessionUser,
  });
}
