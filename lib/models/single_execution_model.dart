import 'package:flutter/foundation.dart';

@immutable
class SingleExecutionModel {
  final bool hasExecuted;
  final double freCompletionRate;

  const SingleExecutionModel({
    required this.hasExecuted,
    required this.freCompletionRate,
  });

  String get completionStatus => freCompletionRate >= 0.70 ? 'Good' : 'Poor';
}
