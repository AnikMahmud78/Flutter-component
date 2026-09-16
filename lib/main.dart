import 'package:flutter/material.dart';
import 'widgets/mobile_reporting_packet.dart';
import 'widgets/pipeline_quality_banner.dart';

void main() {
  runApp(const MobileReportingApp());
}

class MobileReportingApp extends StatelessWidget {
  const MobileReportingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Reporting Views',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const MobileReportingScreen(),
    );
  }
}

class MobileReportingScreen extends StatelessWidget {
  const MobileReportingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Map<String, String> specs = {
      'Mobile Platform': 'Android / Flutter',
      'OS Version': 'API 34 (Android 14)',
      'Device Type': 'Pixel 8 Pro',
      'Screen Dimensions': '${size.width.toInt()}x${size.height.toInt()} dp',
      'Mobile Configuration': 'M3 Baseline / 4px Grid',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Reporting Packet (FIEVR-040-A12)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const PipelineQualityBanner(qualityScore: 1.0, status: 'Complete'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MobileReportingPacket(deviceSpecs: specs),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
