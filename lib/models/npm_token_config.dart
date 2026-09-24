class NpmTokenConfig {
  final String registryUrl;
  final String packageName;
  final String version;
  final double processExecutionAccuracy;
  final bool isTokenValid;

  const NpmTokenConfig({
    required this.registryUrl,
    required this.packageName,
    required this.version,
    required this.processExecutionAccuracy,
    required this.isTokenValid,
  });

  factory NpmTokenConfig.fromJson(Map<String, dynamic> json) {
    return NpmTokenConfig(
      registryUrl: json['registryUrl'] as String,
      packageName: json['packageName'] as String,
      version: json['version'] as String,
      processExecutionAccuracy: (json['processExecutionAccuracy'] as num).toDouble(),
      isTokenValid: json['isTokenValid'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'registryUrl': registryUrl,
        'packageName': packageName,
        'version': version,
        'processExecutionAccuracy': processExecutionAccuracy,
        'isTokenValid': isTokenValid,
      };
}
