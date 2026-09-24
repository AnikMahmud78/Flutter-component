import 'package:flutter/foundation.dart';

@immutable
class HistoryCardModel {
  final String serviceId;
  final String serviceTitle;
  final bool isCompleted;
  final int? rating;

  const HistoryCardModel({
    required this.serviceId,
    required this.serviceTitle,
    required this.isCompleted,
    this.rating,
  });

  String get completionStatus {
    if (rating != null && isCompleted) return 'Complete';
    if (isCompleted) return 'Partial';
    return 'Not Complete';
  }
}
