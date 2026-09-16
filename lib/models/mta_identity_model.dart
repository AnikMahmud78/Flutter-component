// lib/models/mta_identity_model.dart
class MtaIdentityModel {
  final String deviceToken;
  final String memberId;
  final double joinMatchScore;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const MtaIdentityModel({
    required this.deviceToken,
    required this.memberId,
    required this.joinMatchScore,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
