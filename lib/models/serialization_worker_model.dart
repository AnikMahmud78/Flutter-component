// lib/models/serialization_worker_model.dart
class SerializationWorkerModel {
  final int mainThreadDelayMs;
  final bool isIsolateActive;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const SerializationWorkerModel({
    required this.mainThreadDelayMs,
    required this.isIsolateActive,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
