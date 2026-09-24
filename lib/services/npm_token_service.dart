import 'dart:async';
import '../models/npm_token_config.dart';

class NpmTokenService {
  Future<NpmTokenConfig> fetchTokenStatus() async {
    await Future.delayed(const Duration(milliseconds: 80));
    return const NpmTokenConfig(
      registryUrl: "https://npm.pkg.github.com/@habot",
      packageName: "@habot/shared-library",
      version: "2.14.0",
      processExecutionAccuracy: 0.985,
      isTokenValid: true,
    );
  }
}
