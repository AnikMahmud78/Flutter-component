/// Data model tracking atomic video training configuration metadata
class VideoTrainingConfigRecord {
  final String configurationKey;
  final String configurationValue;
  final String configurationType;
  final String validationStatus;
  final String configurationTimestamp;

  VideoTrainingConfigRecord({
    required this.configurationKey,
    required this.configurationValue,
    required this.configurationType,
    required this.validationStatus,
    required this.configurationTimestamp,
  });
}

/// State model managing 60-second video playback, mute, downscaling, and inaction timers
class VideoPlaybackState {
  int secondsRemaining;
  bool isMuted;
  bool isVisible;
  bool isTooltipActive;
  int userInactionSeconds;

  VideoPlaybackState({
    this.secondsRemaining = 60,
    this.isMuted = false,
    this.isVisible = true,
    this.isTooltipActive = false,
    this.userInactionSeconds = 0,
  });

  void resetInactionTimer() {
    userInactionSeconds = 0;
    isTooltipActive = false;
  }
}
