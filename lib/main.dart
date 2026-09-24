import 'package:flutter/material.dart';
import 'models/workday_payload.dart';
import 'services/workday_payload_mapper.dart';

void main() => runApp(const WorkdayMapperApp());

class WorkdayMapperApp extends StatelessWidget {
  const WorkdayMapperApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mapper = WorkdayPayloadMapper();
    final payload = mapper.buildPayload(
      rawId: 'APP-9910',
      rawSsn: '000-11-2222',
      selectedPackage: 'STD_BG_CHECK',
    );
    final isValid = mapper.validateMapping(payload);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Workday Payload Mapping')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Applicant ID: ${payload.applicantId}'),
              Text('Package Code: ${payload.packageCode}'),
              const SizedBox(height: 12),
              Chip(
                label: Text(isValid ? 'Mapping Valid' : 'Mapping Failed'),
                backgroundColor: isValid ? Colors.green.shade100 : Colors.red.shade100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
