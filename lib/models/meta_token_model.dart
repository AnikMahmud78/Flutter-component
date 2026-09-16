// lib/models/meta_token_model.dart
class MetaTokenModel {
  final String datasetId;
  final bool isTokenVerified;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const MetaTokenModel({
    required this.datasetId,
    required this.isTokenVerified,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
