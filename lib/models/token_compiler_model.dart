import 'package:flutter/foundation.dart';

@immutable
class TokenCompilerModel {
  final String compilationJobId;
  final double successRate;

  const TokenCompilerModel({
    required this.compilationJobId,
    required this.successRate,
  });

  String get completionStatus => successRate >= 0.95 ? 'Pass' : 'Fail';
}
