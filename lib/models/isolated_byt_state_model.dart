// Location: lib/models/isolated_byt_state_model.dart
import 'package:flutter/foundation.dart';

/// Immutable State Model bound strictly to a single Byt ID
@immutable
class BytStateRecord {
  final String bytId;
  final String destinationField;
  final String displayLabel;
  final bool isSelected;
  final String inputValue;

  const BytStateRecord({
    required this.bytId,
    required this.destinationField,
    required this.displayLabel,
    this.isSelected = false,
    this.inputValue = '',
  });

  /// Pure Function Copy Method (Immutability Enforced)
  BytStateRecord copyWith({bool? isSelected, String? inputValue}) {
    return BytStateRecord(
      bytId: bytId,
      destinationField: destinationField,
      displayLabel: displayLabel,
      isSelected: isSelected ?? this.isSelected,
      inputValue: inputValue ?? this.inputValue,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BytStateRecord &&
          runtimeType == other.runtimeType &&
          bytId == other.bytId &&
          destinationField == other.destinationField &&
          displayLabel == other.displayLabel &&
          isSelected == other.isSelected &&
          inputValue == other.inputValue;

  @override
  int get hashCode =>
      bytId.hashCode ^
      destinationField.hashCode ^
      displayLabel.hashCode ^
      isSelected.hashCode ^
      inputValue.hashCode;
}

/// Mobile Telemetry Model for Task 3086BPTR-0559 Audits
class MobileStateTelemetryRecord {
  final String mobilePlatform;
  final String osVersion;
  final String deviceType;
  final String screenDimensions;
  final String mobileConfiguration;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  MobileStateTelemetryRecord({
    required this.mobilePlatform,
    required this.osVersion,
    required this.deviceType,
    required this.screenDimensions,
    required this.mobileConfiguration,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
