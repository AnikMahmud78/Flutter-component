/// Represents parent layout dimension tokens that all splintered modules must inherit
class ParentLayoutMetricRegistry {
  final String parentTokenId;
  final String layoutType;
  final String layoutGridDimensions;
  final String spacingRules;
  final String alignmentSettings;

  ParentLayoutMetricRegistry({
    required this.parentTokenId,
    required this.layoutType,
    required this.layoutGridDimensions,
    required this.spacingRules,
    required this.alignmentSettings,
  });

  static final ParentLayoutMetricRegistry defaultMobileParent =
      ParentLayoutMetricRegistry(
        parentTokenId: 'PARENT_GRID_01',
        layoutType: 'SINGLE_COLUMN_MOBILE_STACK',
        layoutGridDimensions: '412dp x 892dp (4-Col Grid)',
        spacingRules: 'Base=8dp, PageMargin=16dp, Gutter=12dp',
        alignmentSettings: 'ALIGN_TOP_START_STRETCH',
      );
}

/// Represents a splintered UI module checking for parent inheritance
class SplinteredModuleMappingRecord {
  final String moduleId;
  final String moduleName;
  final String parentTokenReference;
  final String layoutType;
  final String layoutGridDimensions;
  final String spacingRules;
  final String alignmentSettings;
  String layoutValidationStatus; // INHERITED_PASSED, DEVIATION_REJECTED

  SplinteredModuleMappingRecord({
    required this.moduleId,
    required this.moduleName,
    required this.parentTokenReference,
    required this.layoutType,
    required this.layoutGridDimensions,
    required this.spacingRules,
    required this.alignmentSettings,
    this.layoutValidationStatus = 'INHERITED_PASSED',
  });

  bool get isCompliant => layoutValidationStatus == 'INHERITED_PASSED';
}
