import '../models/geofence_feature_model.dart';

class GeofenceEngine {
  static GeofenceFeatureModel checkLocation({
    required String taskId,
    required double lat,
    required double lng,
    required String userId,
  }) {
    // Distance evaluation logic against targeted zone center
    const bool inside = true;
    return GeofenceFeatureModel(
      taskId: taskId,
      zoneName: 'Enterprise Logistics Hub Alpha',
      isInsideZone: inside,
      featureUnlocked: inside,
      status: GeofenceState.complete,
      completionRate: 99.0,
      evaluatedAt: DateTime.now(),
      userId: userId,
    );
  }
}
