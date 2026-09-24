import 'package:flutter/foundation.dart';

enum ComplianceLevel { high, medium, low }

@immutable
class SopVideoComplianceModel {
  final String taskId;
  final String sopId;
  final String fileExtension;
  final bool isCompressedFormat;
  final ComplianceLevel complianceStatus;
  final double prRejectionRate;
  final DateTime checkedAt;
  final String inspectorId;

  const SopVideoComplianceModel({
    required this.taskId,
    required this.sopId,
    required this.fileExtension,
    required this.isCompressedFormat,
    required this.complianceStatus,
    required this.prRejectionRate,
    required this.checkedAt,
    required this.inspectorId,
  });
}
