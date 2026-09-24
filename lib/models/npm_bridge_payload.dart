class NpmBridgePayload {
  final String packageName;
  final String version;
  final Map<String, dynamic> outputData;
  final bool isVerified;

  NpmBridgePayload({
    required this.packageName,
    required this.version,
    required this.outputData,
    required this.isVerified,
  });
}
