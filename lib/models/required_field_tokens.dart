import 'package:flutter/material.dart';

/// Design system token parameters for required form controls
class RequiredFieldTokens {
  final String systemName;
  final String systemVersion;
  final List<String> componentList;
  final Map<String, dynamic> tokenValues;
  final String documentationLinks;
  final String systemConfigurationDetails;

  RequiredFieldTokens({
    this.systemName = 'Universal Design System Data Entry Directory',
    this.systemVersion = 'v3.4.0-M3',
    this.componentList = const [
      'RequiredFormFieldBuilder',
      'MandatoryAsteriskIndicator',
      'FormLayoutValidator',
    ],
    this.tokenValues = const {
      'asteriskSymbol': '*',
      'asteriskColorHex': '#B3261E',
      'labelFontSizeDp': 13.0,
      'spatialGapDp': 8.0,
      'minTouchTargetDp': 48.0,
      'gridMarginDp': 16.0,
    },
    this.documentationLinks =
        'https://design.internal.net/tokens/required-field-indicators',
    this.systemConfigurationDetails =
        'M3 High-Contrast Red Asterisk Binding Engine with 100% Discovery Coverage',
  });

  /// High-contrast M3 red color token
  static const Color m3SemanticRed = Color(0xFFB3261E);
}
