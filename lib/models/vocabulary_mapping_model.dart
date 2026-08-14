/// Data model tracking vocabulary schema mappings and Poka-Yoke validation status
class VocabularyMappingRecord {
  final String sourceElementId;
  final String targetElementId;
  final String mappingRule;
  String mappingStatus; // VALIDATED, PENDING, REJECTED
  String mappingValidation;
  final List<String> approvedVocabulary;

  VocabularyMappingRecord({
    required this.sourceElementId,
    required this.targetElementId,
    required this.mappingRule,
    this.mappingStatus = 'PENDING',
    this.mappingValidation = 'Awaiting DAMA-DMBOK2 Vocabulary Selection',
    required this.approvedVocabulary,
  });

  /// Poka-Yoke Regex Filter: Validates whether input text matches allowed vocabulary
  bool validateVocabulary(String input) {
    if (input.isEmpty) return false;
    return approvedVocabulary.contains(input.trim());
  }
}
