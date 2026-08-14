import 'package:flutter/material.dart';

enum DeviceFormFactor { compact, medium, expanded }

/// Centralized Material Design 3 Responsive Grid Breakpoint Matrix
class AppResponsiveBreakpoints {
  // Breakpoint Threshold Values
  static const double compactMax = 599.0;
  static const double mediumMin = 600.0;
  static const double mediumMax = 839.0;
  static const double expandedMin = 840.0;

  /// Evaluates current viewport width and returns the active DeviceFormFactor
  static DeviceFormFactor getFormFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mediumMin) {
      return DeviceFormFactor.compact;
    } else if (width <= mediumMax) {
      return DeviceFormFactor.medium;
    } else {
      return DeviceFormFactor.expanded;
    }
  }

  /// Returns grid column count according to viewport specification
  static int getColumnCount(DeviceFormFactor formFactor) {
    switch (formFactor) {
      case DeviceFormFactor.compact:
        return 4; // 4-Column Stack
      case DeviceFormFactor.medium:
        return 8; // 8-Column Grid
      case DeviceFormFactor.expanded:
        return 12; // 12-Column Expansive Grid
    }
  }

  /// Returns standard page margin padding for the active breakpoint
  static double getPageMargin(DeviceFormFactor formFactor) {
    switch (formFactor) {
      case DeviceFormFactor.compact:
        return 16.0; // 16dp Grid Margin
      case DeviceFormFactor.medium:
        return 24.0; // 24dp Grid Margin
      case DeviceFormFactor.expanded:
        return 32.0; // 32dp Grid Margin
    }
  }

  /// Returns standard grid gutter spacing
  static double getGutterSpacing(DeviceFormFactor formFactor) {
    switch (formFactor) {
      case DeviceFormFactor.compact:
        return 12.0;
      case DeviceFormFactor.medium:
        return 16.0;
      case DeviceFormFactor.expanded:
        return 24.0;
    }
  }
}
