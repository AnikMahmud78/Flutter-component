// lib/models/journey_funnel_model.dart
class JourneyFunnelModel {
  final List<String> funnelSteps;
  final bool isMappingComplete;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const JourneyFunnelModel({
    required this.funnelSteps,
    required this.isMappingComplete,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
