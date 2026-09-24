import 'package:flutter/foundation.dart';

@immutable
class AgeVerificationModel {
  final int childAgeYears;
  final int providerMinAgeYears;
  final int providerMaxAgeYears;
  final double captureAccuracy;

  const AgeVerificationModel({
    required this.childAgeYears,
    required this.providerMinAgeYears,
    required this.providerMaxAgeYears,
    required this.captureAccuracy,
  });

  bool get isEligible => childAgeYears >= providerMinAgeYears && childAgeYears <= providerMaxAgeYears;

  String get completionStatus => captureAccuracy >= 0.95 ? 'Pass' : 'Fail';
}
