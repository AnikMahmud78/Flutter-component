// lib/models/pubsub_ack_model.dart
class PubSubAckTelemetry {
  final String messageId;
  final String payloadHash;
  final bool isStoredToDb;
  final bool isAckExecuted;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const PubSubAckTelemetry({
    required this.messageId,
    required this.payloadHash,
    required this.isStoredToDb,
    required this.isAckExecuted,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
