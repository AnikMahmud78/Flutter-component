// lib/models/friction_log_payload.dart
class FrictionLogPayload {
  final String dataPacketId;
  final String stationId;
  final String actionHash;
  final int processingTimeMs;
  final String frictionType;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const FrictionLogPayload({
    required this.dataPacketId,
    required this.stationId,
    required this.actionHash,
    required this.processingTimeMs,
    required this.frictionType,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });

  Map<String, dynamic> toJson() => {
        'data_packet_id': dataPacketId,
        'station_id': stationId,
        'action_hash': actionHash,
        'processing_time_ms': processingTimeMs,
        'friction_type': frictionType,
        'completion_status': completionStatus,
        'action_event_timestamp': actionEventTimestamp,
        'user_session_id': userSessionId,
      };
}
