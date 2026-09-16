// lib/models/sql_ingestion_model.dart
class SqlIngestionModel {
  final String modelName;
  final bool isIngestionComplete;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const SqlIngestionModel({
    required this.modelName,
    required this.isIngestionComplete,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
