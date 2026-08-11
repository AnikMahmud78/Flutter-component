/// Data model representing a Fail-Closed Security Rule Mapping
class FailClosedMapping {
  final String sourceElementId;
  final String targetElementId;
  final String mappingRule;
  final bool isConstraintMet;
  final String mappingStatus;

  FailClosedMapping({
    required this.sourceElementId,
    required this.targetElementId,
    required this.mappingRule,
    required this.isConstraintMet,
    required this.mappingStatus,
  });

  /// Secure-by-Default Logic: If any constraint fails, state defaults to closed/blocked
  bool get isFailClosedActive => !isConstraintMet;
}
