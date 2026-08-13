/// Represents a locked Critical Data Element (CDE) in the End Document (ED) Cloud SQL catalog
class EndDocumentCde {
  final String cdeId;
  final String uiFieldId;
  final String dbTableName;
  final String dbColumnName;
  final String dataType;
  final bool isMandatory;
  final bool isSchemaLocked;
  String currentInputValue;

  EndDocumentCde({
    required this.cdeId,
    required this.uiFieldId,
    required this.dbTableName,
    required this.dbColumnName,
    required this.dataType,
    required this.isMandatory,
    required this.isSchemaLocked,
    this.currentInputValue = '',
  });

  bool get isFieldPopulated => currentInputValue.trim().isNotEmpty;
  bool get isFullyMappedAndValid =>
      isSchemaLocked && (!isMandatory || isFieldPopulated);
}

/// Atomic Telemetry Log Model for End Document (ED) Schema Validation
class EndDocumentValidationTelemetry {
  final String validationType;
  final String validationResult; // PASS / FAIL
  final String errorMessages;
  final String validationTimestamp;
  final String validationLog;

  EndDocumentValidationTelemetry({
    required this.validationType,
    required this.validationResult,
    required this.errorMessages,
    required this.validationTimestamp,
    required this.validationLog,
  });
}
