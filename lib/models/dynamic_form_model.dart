import 'package:flutter/foundation.dart';

enum FieldType { text, number, dropdown, toggle }

class FieldDescriptor {
  final String key;
  final String label;
  final FieldType type;
  final bool isRequired;
  final String? placeholder;
  final List<String>? options;

  const FieldDescriptor({
    required this.key,
    required this.label,
    required this.type,
    this.isRequired = false,
    this.placeholder,
    this.options,
  });
}

class FormTelemetryModel {
  final String libraryName;
  final String libraryVersion;
  final int componentCount;
  final String installationStatus;
  final List<String> dependencyList;
  final String libraryLocationPath;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double formFieldErrorRate;

  const FormTelemetryModel({
    required this.libraryName,
    required this.libraryVersion,
    required this.componentCount,
    required this.installationStatus,
    required this.dependencyList,
    required this.libraryLocationPath,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    required this.formFieldErrorRate,
  });
}
