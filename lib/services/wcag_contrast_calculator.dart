import 'dart:math';
import 'package:flutter/material.dart';
import '../models/contrast_audit_model.dart';

class WcagContrastCalculator {
  static double calculateLuminance(Color color) {
    double r = color.red / 255.0;
    double g = color.green / 255.0;
    double b = color.blue / 255.0;

    r = r <= 0.03928 ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4).toDouble();
    g = g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4).toDouble();
    b = b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4).toDouble();

    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double computeRatio(Color fg, Color bg) {
    double l1 = calculateLuminance(fg);
    double l2 = calculateLuminance(bg);
    double lighter = max(l1, l2);
    double darker = min(l1, l2);
    return (lighter + 0.05) / (darker + 0.05);
  }

  static ContrastAuditModel auditInvertedState({
    required String taskId,
    required Color foreground,
    required Color background,
    required String userId,
  }) {
    final double ratio = computeRatio(foreground, background);
    final bool isCompliant = ratio >= 4.5;
    return ContrastAuditModel(
      taskId: taskId,
      contrastRatio: ratio,
      isInvertedState: true,
      status: isCompliant ? AuditStatus.complete : AuditStatus.notComplete,
      completionRate: isCompliant ? 99.0 : 50.0,
      auditedAt: DateTime.now(),
      inspectorId: userId,
    );
  }
}
