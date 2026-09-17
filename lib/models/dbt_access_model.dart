// lib/models/dbt_access_model.dart
class DbtAccessModel {
  final String repositoryPath;
  final bool isPathValid;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DbtAccessModel({
    required this.repositoryPath,
    required this.isPathValid,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
