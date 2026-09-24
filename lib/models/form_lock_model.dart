import 'package:flutter/foundation.dart';

@immutable
class FormLockModel {
  final bool isFormValid;
  final double lockRatePercentage;

  const FormLockModel({
    required this.isFormValid,
    required this.lockRatePercentage,
  });

  String get completionStatus => lockRatePercentage >= 99.0 ? 'Pass' : 'Fail';
}
