// lib/models/openapi_contract_model.dart
class OpenApiContractModel {
  final String providerName;
  final String endpointPath;
  final bool isSchemaValid;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const OpenApiContractModel({
    required this.providerName,
    required this.endpointPath,
    required this.isSchemaValid,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
