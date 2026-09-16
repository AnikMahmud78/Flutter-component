// lib/models/mcp_server_model.dart
class McpServerModel {
  final String fileName;
  final bool isSyntaxValid;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const McpServerModel({
    required this.fileName,
    required this.isSyntaxValid,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
