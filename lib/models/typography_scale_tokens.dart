import 'package:flutter/material.dart';

/// Atomic typography scale tokens mapped precisely to Material 3 bodyMedium (14pt)
class TypographyScaleTokens {
  final String fontName;
  final double fontSize;
  final double lineHeight;
  final FontWeight fontWeight;
  final String fontFilePath;

  TypographyScaleTokens({
    this.fontName = 'Roboto',
    this.fontSize = 14.0, // Fixed 14pt M3 Token
    this.lineHeight = 1.43, // 20.0 / 14.0 = 1.43
    this.fontWeight = FontWeight.w400, // Regular
    this.fontFilePath = 'assets/fonts/Roboto-Regular.ttf',
  });

  /// Exports TextStyle enforcing strict 14pt bodyMedium token rules
  TextStyle get bodyMedium14pt => TextStyle(
    fontFamily: fontName,
    fontSize: fontSize,
    height: lineHeight,
    fontWeight: fontWeight,
    color: const Color(0xFF1D1B20), // M3 On-Surface
  );
}

/// Represents a record inside the Cloud SQL JSON-backed catalog table
class CloudSqlCatalogEntry {
  final String mappingId;
  final String businessTerm;
  final String logicalDefinition;
  final String downstreamSchemaId;
  final Map<String, dynamic> mappingMetadataJson;

  CloudSqlCatalogEntry({
    required this.mappingId,
    required this.businessTerm,
    required this.logicalDefinition,
    required this.downstreamSchemaId,
    required this.mappingMetadataJson,
  });
}
