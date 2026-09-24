import '../models/sop_video_compliance_model.dart';

class SopMediaValidator {
  static const List<String> allowedFormats = ['mp4', 'webm'];

  static SopVideoComplianceModel validateSopVideo({
    required String taskId,
    required String sopId,
    required String fileExtension,
    required String inspectorId,
  }) {
    final String ext = fileExtension.toLowerCase().replaceAll('.', '');
    final bool isCompliant = allowedFormats.contains(ext);
    
    return SopVideoComplianceModel(
      taskId: taskId,
      sopId: sopId,
      fileExtension: ext,
      isCompressedFormat: isCompliant,
      complianceStatus: isCompliant ? ComplianceLevel.high : ComplianceLevel.low,
      prRejectionRate: isCompliant ? 100.0 : 0.0,
      checkedAt: DateTime.now(),
      inspectorId: inspectorId,
    );
  }
}
