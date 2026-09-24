class SlaStatusPayload {
  final double availabilityRate;
  final bool isBreached;
  final String statusText;

  SlaStatusPayload({
    required this.availabilityRate,
    required this.isBreached,
    required this.statusText,
  });
}
