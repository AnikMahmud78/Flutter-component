// lib/models/lineage_edge_model.dart
class LineageEdgeModel {
  final String parentNodeId;
  final String childNodeId;
  final bool isEdgeAccurate;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const LineageEdgeModel({
    required this.parentNodeId,
    required this.childNodeId,
    required this.isEdgeAccurate,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
