import 'package:flutter/material.dart';

/// Font and typography metadata for WCAG 2.2 AAA contrast auditing
class FontTypographyRecord {
  final String fontName;
  final double fontSize;
  final double lineHeight;
  final String fontWeight;
  final String fontFilePath;

  FontTypographyRecord({
    required this.fontName,
    required this.fontSize,
    required this.lineHeight,
    required this.fontWeight,
    required this.fontFilePath,
  });
}

/// State container for real-time arithmetic reconciliation (A - B = 0)
class ReconciliationState {
  double targetAmountA;
  double reconciledAmountB;
  bool isNetworkFailureSimulated;
  bool isFileCorrupted;

  ReconciliationState({
    this.targetAmountA = 125000.00,
    this.reconciledAmountB = 125000.00,
    this.isNetworkFailureSimulated = false,
    this.isFileCorrupted = false,
  });

  /// Real-Time Triangular Check Variance: A - B
  double get variance => targetAmountA - reconciledAmountB;

  /// Evaluates whether A - B = 0 holds true
  bool get isReconciled => variance.abs() < 0.0001;
}
