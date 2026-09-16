// lib/models/cloud_sql_resource_model.dart
class CloudSqlResourceModel {
  final String instanceName;
  final String databaseVersion;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const CloudSqlResourceModel({
    required this.instanceName,
    required this.databaseVersion,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
