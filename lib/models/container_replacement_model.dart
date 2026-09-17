// lib/models/container_replacement_model.dart
class ContainerReplacementModel {
  final double replacementTimeSecs;
  final bool isReplacementSuccessful;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ContainerReplacementModel({
    required this.replacementTimeSecs,
    required this.isReplacementSuccessful,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
