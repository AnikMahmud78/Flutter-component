import 'package:flutter/material.dart';
import 'models/npm_publisher_model.dart';
import 'widgets/npm_publisher_card.dart';

void main() {
  runApp(const NpmpublisherApp());
}

class NpmpublisherApp extends StatelessWidget {
  const NpmpublisherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artifactory Package Publisher',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NpmpublisherScreen(),
    );
  }
}

class NpmpublisherScreen extends StatelessWidget {
  const NpmpublisherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const publisherModel = NpmpublisherModel(
      packageName: '@habot/shared-library',
      semverVersion: '2.4.0',
      coveragePercentage: 100.0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Private Registry Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            NpmpublisherCard(
              model: publisherModel,
              onPublishPackage: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Package Published to Private Artifactory (v2.4.0)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
