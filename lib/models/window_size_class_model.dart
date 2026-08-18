// Location: lib/models/window_size_class_model.dart

/// Material 3 Window Size Classes based on viewport width
enum M3WindowSizeClass {
  compact, // < 600dp (Mobile)
  medium, // 600dp - 839dp (Tablet)
  expanded, // >= 840dp (Desktop/Large Tablet)
}

/// Layout Grid Properties calculated per Window Size Class
class M3LayoutGridConfig {
  final M3WindowSizeClass sizeClass;
  final int columnCount;
  final double margin;
  final double gutter;

  M3LayoutGridConfig({
    required this.sizeClass,
    required this.columnCount,
    required this.margin,
    required this.gutter,
  });

  /// Calculates grid configuration dynamically based on viewport width
  factory M3LayoutGridConfig.fromWidth(double width) {
    if (width < 600.0) {
      // Compact Viewport (< 600dp): 4 Columns, 16dp Margin, 8dp Gutter
      return M3LayoutGridConfig(
        sizeClass: M3WindowSizeClass.compact,
        columnCount: 4,
        margin: 16.0,
        gutter: 8.0,
      );
    } else if (width < 840.0) {
      // Medium Viewport (600dp - 839dp): 8 Columns, 24dp Margin, 16dp Gutter
      return M3LayoutGridConfig(
        sizeClass: M3WindowSizeClass.medium,
        columnCount: 8,
        margin: 24.0,
        gutter: 16.0,
      );
    } else {
      // Expanded Viewport (>= 840dp): 12 Columns, 32dp Margin, 24dp Gutter
      return M3LayoutGridConfig(
        sizeClass: M3WindowSizeClass.expanded,
        columnCount: 12,
        margin: 32.0,
        gutter: 24.0,
      );
    }
  }

  String get sizeClassName {
    switch (sizeClass) {
      case M3WindowSizeClass.compact:
        return 'COMPACT (< 600dp)';
      case M3WindowSizeClass.medium:
        return 'MEDIUM (600dp - 839dp)';
      case M3WindowSizeClass.expanded:
        return 'EXPANDED (>= 840dp)';
    }
  }
}

/// Atomic Telemetry Model for Task 3064SSTLA-021 Audits
class AdaptiveLayoutTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  AdaptiveLayoutTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
