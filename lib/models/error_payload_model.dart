// lib/models/error_payload_model.dart
// Task GEN-00136: Error Payload Schema Standardization Engine
class ErrorPayloadModel {
  final String errorCode;
  final String errorMessage;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ErrorPayloadModel({
    required this.errorCode,
    required this.errorMessage,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
