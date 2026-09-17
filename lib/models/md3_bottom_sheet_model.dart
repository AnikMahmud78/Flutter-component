// lib/models/md3_bottom_sheet_model.dart
class Md3BottomSheetModel {
  final double minTouchTargetDp;
  final bool isWcagCompliant;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const Md3BottomSheetModel({
    required this.minTouchTargetDp,
    required this.isWcagCompliant,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
