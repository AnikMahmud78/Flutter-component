/// Data model tracking located FAB button label definition parameters
class FabDefinitionRecord {
  final String definitionName;
  final String definitionParameters;
  final String definitionType;
  final String validationStatus;
  final String definitionId;

  FabDefinitionRecord({
    required this.definitionName,
    required this.definitionParameters,
    required this.definitionType,
    required this.validationStatus,
    required this.definitionId,
  });
}

/// Centralized repository of located FAB Objective System-Verbs
class FabSystemVerbDictionary {
  static const String executeIngestion = 'EXECUTE_INGESTION';
  static const String commitRecord = 'COMMIT_RECORD';
  static const String authenticateSession = 'AUTHENTICATE_SESSION';
  static const String purgeCache = 'PURGE_CACHE';

  static final List<FabDefinitionRecord> locatedDefinitions = [
    FabDefinitionRecord(
      definitionName: 'FAB_PRIMARY_INGESTION_TRIGGER',
      definitionParameters:
          'SystemVerb=EXECUTE_INGESTION, MinTarget=48dp, Contrast=6.8:1',
      definitionType: 'OBJECTIVE_SYSTEM_VERB_FAB',
      validationStatus: 'VALIDATED_WCAG_AA',
      definitionId: 'FAB_DEF_001',
    ),
    FabDefinitionRecord(
      definitionName: 'FAB_SECONDARY_COMMIT_TRIGGER',
      definitionParameters:
          'SystemVerb=COMMIT_RECORD, MinTarget=48dp, Contrast=7.2:1',
      definitionType: 'OBJECTIVE_SYSTEM_VERB_FAB',
      validationStatus: 'VALIDATED_WCAG_AA',
      definitionId: 'FAB_DEF_002',
    ),
    FabDefinitionRecord(
      definitionName: 'FAB_SECURITY_AUTHENTICATE_TRIGGER',
      definitionParameters:
          'SystemVerb=AUTHENTICATE_SESSION, MinTarget=48dp, Contrast=8.1:1',
      definitionType: 'OBJECTIVE_SYSTEM_VERB_FAB',
      validationStatus: 'VALIDATED_WCAG_AA',
      definitionId: 'FAB_DEF_003',
    ),
    FabDefinitionRecord(
      definitionName: 'FAB_MEMORY_PURGE_TRIGGER',
      definitionParameters:
          'SystemVerb=PURGE_CACHE, MinTarget=48dp, Contrast=7.5:1',
      definitionType: 'OBJECTIVE_SYSTEM_VERB_FAB',
      validationStatus: 'VALIDATED_WCAG_AA',
      definitionId: 'FAB_DEF_004',
    ),
  ];
}
