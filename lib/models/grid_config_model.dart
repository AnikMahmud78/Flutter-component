class GridConfigModel {
  final String layoutConfiguration;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const GridConfigModel({
    required this.layoutConfiguration,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
