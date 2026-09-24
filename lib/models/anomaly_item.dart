class AnomalyItem {
  final String anomalyId;
  final String severity; // High, Critical
  final String description;
  final DateTime detectedAt;

  const AnomalyItem({
    required this.anomalyId,
    required this.severity,
    required this.description,
    required this.detectedAt,
  });
}
