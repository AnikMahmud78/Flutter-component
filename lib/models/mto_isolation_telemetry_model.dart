// Location: lib/models/mto_isolation_telemetry_model.dart

/// Classification of broken data block types encountered during MTO processing
enum BrokenBlockType {
  ocrRegexMismatch,
  lowConfidenceSnippet,
  checksumParityFailure,
  formatMaskViolation,
}

/// Model representing an isolated broken data block
class BrokenDataBlock {
  final String blockId;
  final BrokenBlockType blockType;
  final String isolatedSnippetText;
  final String expectedFormatPattern;
  final String fieldLabel;
  bool isResolved;
  String? correctedValue;

  BrokenDataBlock({
    required this.blockId,
    required this.blockType,
    required this.isolatedSnippetText,
    required this.expectedFormatPattern,
    required this.fieldLabel,
    this.isResolved = false,
    this.correctedValue,
  });

  String get blockTypeName {
    switch (blockType) {
      case BrokenBlockType.ocrRegexMismatch:
        return 'OCR_REGEX_MISMATCH';
      case BrokenBlockType.lowConfidenceSnippet:
        return 'LOW_CONFIDENCE_SNIPPET';
      case BrokenBlockType.checksumParityFailure:
        return 'CHECKSUM_PARITY_FAILURE';
      case BrokenBlockType.formatMaskViolation:
        return 'FORMAT_MASK_VIOLATION';
    }
  }
}

/// Atomic Telemetry Record for Task 3163SSTLA-013 Audits
class MtoLockTelemetryRecord {
  final String lockType;
  final String lockStatus;
  final String lockedBy;
  final String lockTimestamp;
  final String lockReason;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  MtoLockTelemetryRecord({
    required this.lockType,
    required this.lockStatus,
    required this.lockedBy,
    required this.lockTimestamp,
    required this.lockReason,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
