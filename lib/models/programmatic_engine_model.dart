/// Represents individual component node specifications in the backend JSON payload
class ComponentSchemaNode {
  final String type;
  final Map<String, dynamic> properties;

  ComponentSchemaNode({required this.type, required this.properties});

  factory ComponentSchemaNode.fromJson(Map<String, dynamic> json) {
    return ComponentSchemaNode(
      type: json['type'] as String,
      properties: json['properties'] as Map<String, dynamic>? ?? {},
    );
  }
}

/// Data model tracking atomic build telemetry logs for the programmatic layout engine
class ProgrammaticEngineBuildTelemetry {
  final String buildStatus;
  final String buildTimestamp;
  final String buildArtifactsPath;
  final String buildLogs;
  final String buildDuration;

  ProgrammaticEngineBuildTelemetry({
    required this.buildStatus,
    required this.buildTimestamp,
    required this.buildArtifactsPath,
    required this.buildLogs,
    required this.buildDuration,
  });
}
