// lib/models/attribution_model.dart
class AttributionModel {
  final String id;
  final String? predecessorId;
  final String sourceDocumentId;
  final String campaignToken;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AttributionModel({
    required this.id,
    this.predecessorId,
    required this.sourceDocumentId,
    required this.campaignToken,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'predecessor_id': predecessorId,
        'source_document_id': sourceDocumentId,
        'campaign_token': campaignToken,
        'completion_status': completionStatus,
        'action_event_timestamp': actionEventTimestamp,
        'user_session_id': userSessionId,
      };
}
