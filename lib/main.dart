import 'package:flutter/material.dart';
import 'widgets/dashboard_byt_component.dart';
import 'models/package_commit_manifest.dart';

void main() {
  runApp(const ComponentCommitApp());
}

class ComponentCommitApp extends StatelessWidget {
  const ComponentCommitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manifest = PackageCommitManifest(
      componentName: 'Engineering Dashboard Byt',
      libraryTarget: '@habot/shared-library/dashboard-byt',
      versionTag: 'v2.15.0-RELEASE',
      isCommitted: true,
    );

    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: Scaffold(
        appBar: AppBar(title: const Text('Design System Package Commit')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DashboardBytComponent(manifest: manifest),
          ),
        ),
      ),
    );
  }
}
