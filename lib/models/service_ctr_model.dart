// lib/models/service_ctr_model.dart
class ServiceCtrModel {
  final String dataRefreshLatency;
  final double ctrValue;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ServiceCtrModel({
    required this.dataRefreshLatency,
    required this.ctrValue,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
