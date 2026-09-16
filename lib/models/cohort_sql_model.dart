// lib/models/cohort_sql_model.dart
class CohortSqlModel {
  final String fileName;
  final bool isSyntaxValid;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const CohortSqlModel({
    required this.fileName,
    required this.isSyntaxValid,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
