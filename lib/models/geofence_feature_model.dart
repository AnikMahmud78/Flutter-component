import 'package:flutter/foundation.dart';

enum GeofenceState { complete, partial, notComplete }

@immutable
class GeofenceFeatureModel {
  final String taskId;
  final String zoneName;
  final bool isInsideZone;
  final bool featureUnlocked;
  final GeofenceState status;
  final double completionRate;
  final DateTime evaluatedAt;
  final String userId;

  const GeofenceFeatureModel({
    required this.taskId,
    required this.zoneName,
    required this.isInsideZone,
    required this.featureUnlocked,
    required this.status,
    required this.completionRate,
    required this.evaluatedAt,
    required this.userId,
  });
}
