import 'package:flutter/foundation.dart';

@immutable
class FigmaTokenMapModel {
  final String figmaFileId;
  final double mappingCompletionRate;

  const FigmaTokenMapModel({
    required this.figmaFileId,
    required this.mappingCompletionRate,
  });

  String get completionStatus {
    if (mappingCompletionRate >= 99.0) return 'Complete';
    if (mappingCompletionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
