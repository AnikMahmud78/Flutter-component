import 'package:flutter/foundation.dart';

@immutable
class DisputeTicketModel {
  final String disputeId;
  final String ticketNumber;
  final bool isSlaTimerActive;
  final int cycleTimeHours;

  const DisputeTicketModel({
    required this.disputeId,
    required this.ticketNumber,
    required this.isSlaTimerActive,
    required this.cycleTimeHours,
  });

  String get completionStatus {
    if (cycleTimeHours <= 48 && isSlaTimerActive) return 'Good';
    if (cycleTimeHours <= 120 && isSlaTimerActive) return 'Average';
    return 'Poor';
  }
}
