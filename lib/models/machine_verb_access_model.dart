/// Centralized Repository for English Code (EC) Machine-Action Verbs
class EcMachineVerbs {
  static const String executeIngestion = 'EXECUTE_INGESTION';
  static const String commitRecord = 'COMMIT_RECORD';
  static const String revokeAccess = 'REVOKE_ACCESS';
  static const String authenticateSession = 'AUTHENTICATE_SESSION';
  static const String purgeCache = 'PURGE_CACHE';
}

/// Data model tracking user access telemetry and permission levels
class MachineVerbAccessModel {
  final String accessType;
  final String userRole;
  final String permissionLevel;
  final String accessLog;
  final String accessTimestamp;

  MachineVerbAccessModel({
    required this.accessType,
    required this.userRole,
    required this.permissionLevel,
    required this.accessLog,
    required this.accessTimestamp,
  });
}
