/// Data model representing atomic metadata fields deconstructed from legacy composite strings
class DocumentMetadataModel {
  String documentTitle;
  String documentUrl;
  String lastUpdatedDate;
  String accessibilityStatus;
  String documentAccessLog;

  DocumentMetadataModel({
    required this.documentTitle,
    required this.documentUrl,
    required this.lastUpdatedDate,
    required this.accessibilityStatus,
    required this.documentAccessLog,
  });

  /// Poka-Yoke Linter: Validates that no composite strings remain in individual fields
  static bool containsCompositeDelimiter(String value) {
    // Rejects strings containing legacy composite separators like '|', ';', or '::'
    return value.contains('|') || value.contains(';') || value.contains('::');
  }

  /// Deconstructs a legacy composite string into an atomic DocumentMetadataModel instance
  static DocumentMetadataModel? parseCompositeString(String composite) {
    if (!composite.contains('|')) return null;
    final parts = composite.split('|');
    if (parts.length < 5) return null;

    return DocumentMetadataModel(
      documentTitle: parts[0].trim(),
      documentUrl: parts[1].trim(),
      lastUpdatedDate: parts[2].trim(),
      accessibilityStatus: parts[3].trim(),
      documentAccessLog: parts[4].trim(),
    );
  }
}
