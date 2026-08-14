/// Data model tracking business rule and breakpoint threshold policy definitions
class LayoutDefinitionModel {
  final String definitionName;
  final String definitionParameters;
  final String definitionType;
  final String validationStatus;
  final String definitionId;
  final double thresholdCoverage; // Target: 1.0 (100%)
  final String completionStatus; // Complete

  LayoutDefinitionModel({
    this.definitionName = 'M3 Grid Breakpoint Matrix Policy',
    this.definitionParameters =
        'Compact (<600dp/4col), Medium (600-839dp/8col), Expanded (>=840dp/12col)',
    this.definitionType = 'LAYOUT_GRID_SPECIFICATION',
    this.validationStatus = 'PEER_REVIEWED_AND_VERSIONED',
    this.definitionId = 'DEF-BRK-2107-RCGLA',
    this.thresholdCoverage = 1.0,
    this.completionStatus = 'Complete',
  });
}
