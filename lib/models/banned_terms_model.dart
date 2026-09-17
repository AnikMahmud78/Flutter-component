// lib/models/banned_terms_model.dart
class BannedTermsModel {
  final List<String> masterBannedList;
  final bool isDictionaryComplete;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const BannedTermsModel({
    required this.masterBannedList,
    required this.isDictionaryComplete,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
