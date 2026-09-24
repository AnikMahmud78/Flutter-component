class NotificationBytModel {
  final String bytId;
  final String title;
  final String body;
  final double deliveryRate;
  final DateTime timestamp;

  const NotificationBytModel({
    required this.bytId,
    required this.title,
    required this.body,
    required this.deliveryRate,
    required this.timestamp,
  });
}
