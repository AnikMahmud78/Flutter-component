/// Represents rate-limiting stats for a specific API endpoint
class BlockedEndpointMetric {
  final String endpointPath;
  final int totalRequests;
  final int blockedRequests;
  final int rateLimitThreshold;

  BlockedEndpointMetric({
    required this.endpointPath,
    required this.totalRequests,
    required this.blockedRequests,
    required this.rateLimitThreshold,
  });

  double get blockRateRatio => totalRequests > 0
      ? (blockedRequests / totalRequests).clamp(0.0, 1.0)
      : 0.0;

  int get blockPercentage => (blockRateRatio * 100).round();
}

/// Represents threat telemetry for a blocked source IP
class BlockedIpMetric {
  final String ipAddress;
  final String locationRegion;
  final int blockedCount;
  final String threatLevel; // HIGH, MEDIUM, LOW

  BlockedIpMetric({
    required this.ipAddress,
    required this.locationRegion,
    required this.blockedCount,
    required this.threatLevel,
  });
}

/// RAIL Model Performance Evaluation
class RailLoadPerformance {
  final double loadTimeSeconds;

  RailLoadPerformance({required this.loadTimeSeconds});

  String get performanceRating {
    if (loadTimeSeconds <= 2.0) {
      return 'Good'; // Optimal
    } else if (loadTimeSeconds <= 5.0) {
      return 'Average'; // Floor
    } else {
      return 'Poor'; // Ceiling/Fail
    }
  }
}
