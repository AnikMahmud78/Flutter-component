import '../models/aps_metric_model.dart';

class ApsMetricService {
  static Future<bool> storeApsMetric(ApsMetricModel metric) async {
    // Persist to HR Performance store
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }
}
