// lib/models/bigquery_cluster_model.dart
class BigQueryClusterModel {
  final String tableName;
  final String clusterKey;
  final double lookupSpeedMs;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const BigQueryClusterModel({
    required this.tableName,
    required this.clusterKey,
    required this.lookupSpeedMs,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
