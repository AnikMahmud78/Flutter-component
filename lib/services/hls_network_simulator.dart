import '../models/video_3g_playback_model.dart';

class HlsNetworkSimulator {
  static Video3gPlaybackModel evaluate3gPlayback({
    required String taskId,
    required String mediaUrl,
    required String userId,
  }) {
    // Simulated 3G fast start with chunk pre-fetching
    const double startupLatency = 240.0; // milliseconds
    const double successRate = 99.5;
    
    return Video3gPlaybackModel(
      taskId: taskId,
      mediaUrl: mediaUrl,
      startupLatencyMs: startupLatency,
      playbackSuccessRate: successRate,
      health: PlaybackHealth.high,
      timestamp: DateTime.now(),
      sessionUser: userId,
    );
  }
}
