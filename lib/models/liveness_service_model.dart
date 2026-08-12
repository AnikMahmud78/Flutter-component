enum HealthStatus { healthy, degraded, failed }

/// Represents an infrastructure service endpoint monitored by the liveness engine
class LivenessServiceNode {
  final String id;
  final String name;
  final String endpointUrl;
  HealthStatus status;
  int latencyMs;
  DateTime lastChecked;
  int selfHealingCount;

  LivenessServiceNode({
    required this.id,
    required this.name,
    required this.endpointUrl,
    this.status = HealthStatus.healthy,
    this.latencyMs = 45,
    required this.lastChecked,
    this.selfHealingCount = 0,
  });

  bool get isHealthy => status == HealthStatus.healthy;
  bool get isFailed => status == HealthStatus.failed;
}
