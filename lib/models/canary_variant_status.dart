class CanaryVariantStatus {
  final String variantId;
  final double errorRatePercent;
  final bool isRolledBack;
  final String activeRelease;

  CanaryVariantStatus({
    required this.variantId,
    required this.errorRatePercent,
    required this.isRolledBack,
    required this.activeRelease,
  });
}
