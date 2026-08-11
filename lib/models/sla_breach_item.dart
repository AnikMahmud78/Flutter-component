/// Data model representing a 15-Minute Chat SLA Breach
class SlaBreachItem {
  final String id;
  final String customerName;
  final String channel;
  final String missedMessage;
  final int waitTimeMinutes;
  final String timestamp;
  bool isAcknowledged;

  SlaBreachItem({
    required this.id,
    required this.customerName,
    required this.channel,
    required this.missedMessage,
    required this.waitTimeMinutes,
    required this.timestamp,
    this.isAcknowledged = false,
  });
}
