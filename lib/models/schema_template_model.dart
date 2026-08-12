/// Represents an individual normalized column definition inside the raw schema template
class SchemaColumnDefinition {
  final int lineNumber;
  final String columnName;
  final String dataType;
  final bool isNullable;
  final String checksum;

  SchemaColumnDefinition({
    required this.lineNumber,
    required this.columnName,
    required this.dataType,
    required this.isNullable,
    required this.checksum,
  });
}

/// Data model representing the Destination Schema Template and device environment telemetry
class SchemaTemplateModel {
  final String tableName;
  final String catalogName;
  final String schemaVersion;
  final String masterChecksumHash;
  final bool isNormalizedPokaYokePassed;
  final List<SchemaColumnDefinition> columns;

  // Required Atomic Telemetry Fields
  final String mobilePlatform;
  final String osVersion;
  final String deviceType;
  final String screenDimensions;
  final String mobileConfiguration;

  SchemaTemplateModel({
    required this.tableName,
    required this.catalogName,
    required this.schemaVersion,
    required this.masterChecksumHash,
    required this.isNormalizedPokaYokePassed,
    required this.columns,
    required this.mobilePlatform,
    required this.osVersion,
    required this.deviceType,
    required this.screenDimensions,
    required this.mobileConfiguration,
  });
}
