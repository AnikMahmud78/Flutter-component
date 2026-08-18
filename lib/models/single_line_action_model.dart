import 'package:flutter/material.dart';

/// Font typography metadata tracking exact button label styling specs
class ActionTypographyRecord {
  final String fontName;
  final double fontSize;
  final double lineHeight;
  final FontWeight fontWeight;
  final String fontFilePath;

  ActionTypographyRecord({
    required this.fontName,
    required this.fontSize,
    required this.lineHeight,
    required this.fontWeight,
    required this.fontFilePath,
  });

  String get fontWeightString => fontWeight.toString();
}

/// Systemic action verb definition pairing action text with typographic specifications
class SystemicActionVerb {
  final String verbKey;
  final String displayLabel;
  final ActionTypographyRecord typography;

  SystemicActionVerb({
    required this.verbKey,
    required this.displayLabel,
    required this.typography,
  });

  static final List<SystemicActionVerb> availableVerbs = [
    SystemicActionVerb(
      verbKey: 'EXECUTE_INGESTION',
      displayLabel: 'EXECUTE_DATA_INGESTION',
      typography: ActionTypographyRecord(
        fontName: 'Roboto_Medium_Condensed',
        fontSize: 13.0,
        lineHeight: 1.2,
        fontWeight: FontWeight.w700,
        fontFilePath: 'assets/fonts/Roboto-Bold.ttf',
      ),
    ),
    SystemicActionVerb(
      verbKey: 'COMMIT_RECORD',
      displayLabel: 'COMMIT_SCHEMA_RECORD',
      typography: ActionTypographyRecord(
        fontName: 'Monospace_Bold_Tracked',
        fontSize: 12.5,
        lineHeight: 1.15,
        fontWeight: FontWeight.w900,
        fontFilePath: 'assets/fonts/JetBrainsMono-Bold.ttf',
      ),
    ),
    SystemicActionVerb(
      verbKey: 'AUTHENTICATE_SESSION',
      displayLabel: 'AUTHENTICATE_OPERATOR_SESSION',
      typography: ActionTypographyRecord(
        fontName: 'Roboto_Semibold',
        fontSize: 13.5,
        lineHeight: 1.25,
        fontWeight: FontWeight.w600,
        fontFilePath: 'assets/fonts/Roboto-Medium.ttf',
      ),
    ),
  ];
}
