// lib/models/utm_link_model.dart
class UtmLinkModel {
  final String rawUrl;
  final String utmSource;
  final String utmMedium;
  final String utmCampaign;
  final String utmContent;
  final String traceId;
  final String generatedShortUrl;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const UtmLinkModel({
    required this.rawUrl,
    required this.utmSource,
    required this.utmMedium,
    required this.utmCampaign,
    required this.utmContent,
    required this.traceId,
    required this.generatedShortUrl,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
