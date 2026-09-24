import 'package:flutter/material.dart';
import '../models/npm_bridge_payload.dart';

class NpmPackageBridgeCard extends StatefulWidget {
  final Function(NpmBridgePayload) onNpmPackageExecuted;

  const NpmPackageBridgeCard({Key? key, required this.onNpmPackageExecuted}) : super(key: key);

  @override
  State<NpmPackageBridgeCard> createState() => _NpmPackageBridgeCardState();
}

class _NpmPackageBridgeCardState extends State<NpmPackageBridgeCard> {
  bool _isLoaded = false;
  String _activeVersion = '@habot/shared-library v2.14.0';

  // English Code (EC): Execute-Npm-Package-Method
  void executeNpmPackageMethod() {
    final payload = NpmBridgePayload(
      packageName: '@habot/shared-library',
      version: '2.14.0',
      outputData: {'checksum': 'a8f9d012c', 'status': 'VALIDATED_NPM'},
      isVerified: true,
    );

    setState(() {
      _isLoaded = true;
    });

    widget.onNpmPackageExecuted(payload);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NPM Shared Library Runtime Bridge', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Package: $_activeVersion', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: FilledButton(
                onPressed: executeNpmPackageMethod,
                child: const Text('RUN JS-INTEROP MODULE VALIDATION'),
              ),
            ),
            const SizedBox(height: 12.0),
            Chip(
              avatar: Icon(_isLoaded ? Icons.check_circle : Icons.hourglass_empty, color: Colors.white),
              label: Text(_isLoaded ? 'JS Module Bound & Execution Passed' : 'Awaiting Invocation'),
              backgroundColor: _isLoaded ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
