// lib/models/lookml_file_model.dart
class LookmlFileModel {
  final String fileName;
  final bool isSyntaxValid;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const LookmlFileModel({
    required this.fileName,
    required this.isSyntaxValid,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
