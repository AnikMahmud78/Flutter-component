import 'package:flutter/foundation.dart';

@immutable
class ServiceDetailModel {
  final String serviceId;
  final String title;
  final String providerName;
  final double hourlyRate;
  final double rating;
  final double iaTaskSuccessRate;

  const ServiceDetailModel({
    required this.serviceId,
    required this.title,
    required this.providerName,
    required this.hourlyRate,
    required this.rating,
    required this.iaTaskSuccessRate,
  });

  String get completionStatus {
    if (iaTaskSuccessRate >= 0.95) return 'Good';
    if (iaTaskSuccessRate >= 0.80) return 'Average';
    return 'Poor';
  }
}
