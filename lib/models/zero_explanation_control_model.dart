// lib/models/zero_explanation_control_model.dart
// Task GEN-00359: Verify that mobile interface controls require zero explanation during UAT trials.

class ZeroExplanationControlModel {
  final String trialId;
  final double selfExplanatoryScore;
  final String completionStatus;
  final String agileStandard;
  final String timestamp;

  const ZeroExplanationControlModel({
    required this.trialId,
    required this.selfExplanatoryScore,
    required this.completionStatus,
    required this.agileStandard,
    required this.timestamp,
  });
}
