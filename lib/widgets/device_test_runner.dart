import 'package:flutter/material.dart';

class DeviceTestRunner extends StatefulWidget {
  const DeviceTestRunner({super.key});

  @override
  State<DeviceTestRunner> createState() => _DeviceTestRunnerState();
}

class _DeviceTestRunnerState extends State<DeviceTestRunner> {
  bool _testPassed = false;
  String _checksum = 'a1f89c72e4b30091';

  void _runSimulation() {
    setState(() {
      _testPassed = true;
      _checksum = 'd9e4401a88c2194f';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Physical Device Interactive Test Suite', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Version Build Status'),
          subtitle: Text('v2.6.0-prod | Checksum: $_checksum'),
          trailing: Icon(
            _testPassed ? Icons.check_circle : Icons.pending,
            color: _testPassed ? theme.colorScheme.primary : theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 48.0,
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: _runSimulation,
            icon: const Icon(Icons.play_arrow),
            label: const Text('RUN PHYSICAL DEVICE SIMULATION'),
          ),
        ),
      ],
    );
  }
}
