// lib/models/mobile_funnel_template_model.dart
class MobileFunnelTemplateModel {
  final double funnelCompletionRate;
  final String templatePackage;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const MobileFunnelTemplateModel({
    required this.funnelCompletionRate,
    required this.templatePackage,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
