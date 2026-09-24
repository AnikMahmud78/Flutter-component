import 'package:flutter/foundation.dart';

@immutable
class ModalFocusModel {
  final bool isModalOpen;
  final double prRejectionRate;

  const ModalFocusModel({
    required this.isModalOpen,
    required this.prRejectionRate,
  });

  String get completionStatus {
    if (prRejectionRate >= 99.0) return 'High';
    if (prRejectionRate >= 95.0) return 'Medium';
    return 'Low';
  }
}
