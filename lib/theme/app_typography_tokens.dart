import 'package:flutter/material.dart';

/// Centralized Material Design 3 Typography Scale Tokens & System Font Rules
class AppTypographyTokens {
  static const String systemFontFamily = 'Roboto';

  // High-Contrast Surface Colors (WCAG 2.1 AA >= 4.5:1)
  static const Color onSurfaceHighContrast = Color(0xFF1D1B20);
  static const Color onSurfaceVariantContrast = Color(0xFF49454F);
  static const Color primaryActionContrast = Color(0xFF005AC1);
  static const Color errorContrast = Color(0xFFB3261E);

  /// Generates the immutable MD3 TextTheme for application-wide binding
  static TextTheme buildMd3TextTheme() {
    return const TextTheme(
      // DISPLAY LARGE: 57sp / Line-height 64dp (Multiplier: 1.12)
      displayLarge: TextStyle(
        fontFamily: systemFontFamily,
        fontSize: 57.0,
        height: 1.12,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: onSurfaceHighContrast,
      ),

      // HEADLINE MEDIUM: 28sp / Line-height 36dp (Multiplier: 1.28)
      headlineMedium: TextStyle(
        fontFamily: systemFontFamily,
        fontSize: 28.0,
        height: 1.28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: onSurfaceHighContrast,
      ),

      // TITLE MEDIUM: 16sp / Line-height 24dp (Multiplier: 1.50)
      titleMedium: TextStyle(
        fontFamily: systemFontFamily,
        fontSize: 16.0,
        height: 1.50,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: onSurfaceHighContrast,
      ),

      // BODY LARGE (Paragraph Baseline): 16sp / Line-height 24dp (Multiplier: 1.50)
      bodyLarge: TextStyle(
        fontFamily: systemFontFamily,
        fontSize: 16.0, // Anchored 16sp reading baseline
        height: 1.50,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.50,
        color: onSurfaceHighContrast,
      ),

      // BODY MEDIUM: 14sp / Line-height 20dp (Multiplier: 1.43)
      bodyMedium: TextStyle(
        fontFamily: systemFontFamily,
        fontSize: 14.0,
        height: 1.43,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: onSurfaceVariantContrast,
      ),

      // LABEL LARGE: 14sp / Line-height 20dp (Multiplier: 1.43)
      labelLarge: TextStyle(
        fontFamily: systemFontFamily,
        fontSize: 14.0,
        height: 1.43,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.10,
        color: primaryActionContrast,
      ),
    );
  }
}
