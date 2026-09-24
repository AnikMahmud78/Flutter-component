import 'package:flutter/foundation.dart';

@immutable
class NotificationPromptModel {
  final String frequencySetting;
  final double verificationScore;

  const NotificationPromptModel({
    required this.frequencySetting,
    required this.verificationScore,
  });

  String get completionStatus => verificationScore >= 0.90 ? 'Good' : 'Poor';
}
