import 'package:flutter/material.dart';
import 'widgets/staging_deployment_status_widget_13965FEBFL011A16.dart';

void main() {
  runApp(const StagingDeploymentApp13965FEBFL011A16());
}

class StagingDeploymentApp13965FEBFL011A16 extends StatelessWidget {
  const StagingDeploymentApp13965FEBFL011A16({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Staging Deployment App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const StagingDeploymentStatusWidget13965FEBFL011A16(),
    );
  }
}
