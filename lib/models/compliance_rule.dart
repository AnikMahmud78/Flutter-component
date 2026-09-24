class ComplianceRule {
  final String ruleId;
  final String fieldName;
  final String errorMessage;
  final bool isViolated;

  ComplianceRule({
    required this.ruleId,
    required this.fieldName,
    required this.errorMessage,
    required this.isViolated,
  });
}
