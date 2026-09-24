import 'package:flutter/foundation.dart';

@immutable
class PokaYokeTelemetry {
  final String transactionId;
  final double amount;
  final String completionStatus; // 'Complete', 'Partial', 'Not Complete'
  final bool isFraudBlocked;
  final String violationReason;
  final DateTime timestamp;
  final String userId;

  const PokaYokeTelemetry({
    required this.transactionId,
    required this.amount,
    required this.completionStatus,
    required this.isFraudBlocked,
    required this.violationReason,
    required this.timestamp,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'transaction_id': transactionId,
        'amount': amount,
        'completion_status': completionStatus,
        'is_fraud_blocked': isFraudBlocked,
        'violation_reason': violationReason,
        'event_timestamp': timestamp.toIso8601String(),
        'user_id': userId,
      };
}
