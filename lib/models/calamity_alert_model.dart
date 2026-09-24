class CalamityAlertModel {
  final String alertId;
  final String description;
  final bool isCleared;
  final String requiredFixLogic;

  CalamityAlertModel({
    required this.alertId,
    required this.description,
    required this.isCleared,
    required this.requiredFixLogic,
  });
}
