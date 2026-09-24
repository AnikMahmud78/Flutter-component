import 'package:flutter/material.dart';
import 'widgets/npm_package_bridge.dart';

void main() {
  runApp(const NpmBridgeApp());
}

class NpmBridgeApp extends StatelessWidget {
  const NpmBridgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: Scaffold(
        appBar: AppBar(title: const Text('NPM Integration Bridge Console')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: NpmPackageBridgeCard(
            onNpmPackageExecuted: (payload) {
              debugPrint('NPM Module Executed: ${payload.packageName} - ${payload.version}');
            },
          ),
        ),
      ),
    );
  }
}
