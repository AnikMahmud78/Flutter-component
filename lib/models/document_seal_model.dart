/// Represents individual lifecycle steps of a Master EC Document
enum DocumentLifecycleStep { draft, inReview, approved, sealedEd4 }

/// Data model tracking Master EC Document metadata and sealing state
class MasterDocumentRecord {
  final String documentId;
  final String title;
  final String versionTag;
  DocumentLifecycleStep currentStep;

  MasterDocumentRecord({
    required this.documentId,
    required this.title,
    required this.versionTag,
    this.currentStep = DocumentLifecycleStep.draft,
  });

  bool get isSealed => currentStep == DocumentLifecycleStep.sealedEd4;
}

/// Data model tracking atomic telemetry for DAMA-DMBOK2 metadata completeness audits
class DocumentSealTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;

  DocumentSealTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
  });
}
