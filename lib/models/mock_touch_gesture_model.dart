// lib/models/mock_touch_gesture_model.dart
// Task GEN-00315: Mock touch gesture events inside automated UI unit tests.

class MockTouchGestureModel {
  final String testSuiteName;
  final int mockedGesturesCount;
  final String completionStatus;
  final String runnerTimestamp;

  const MockTouchGestureModel({
    required this.testSuiteName,
    required this.mockedGesturesCount,
    required this.completionStatus,
    required this.runnerTimestamp,
  });
}
