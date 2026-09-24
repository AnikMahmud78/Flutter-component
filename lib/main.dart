import 'package:flutter/material.dart';
import 'models/sop_video_compliance_model.dart';
import 'services/sop_media_validator.dart';
import 'widgets/video_format_card.dart';
import 'widgets/pr_rejection_banner.dart';

void main() {
  runApp(const HABOTSopMediaApp());
}

class HABOTSopMediaApp extends StatelessWidget {
  const HABOTSopMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10159GEN-01927 SOP Media Compression',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006874)),
      ),
      home: const SopMediaScreen(),
    );
  }
}

class SopMediaScreen extends StatefulWidget {
  const SopMediaScreen({super.key});

  @override
  State<SopMediaScreen> createState() => _SopMediaScreenState();
}

class _SopMediaScreenState extends State<SopMediaScreen> {
  late SopVideoComplianceModel _model;

  @override
  void initState() {
    super.initState();
    _checkFile();
  }

  void _checkFile() {
    setState(() {
      _model = SopMediaValidator.validateSopVideo(
        taskId: '10159GEN-01927',
        sopId: 'SOP-MOBILE-1092',
        fileExtension: 'mp4',
        inspectorId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SOP Video Format Enforcer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PrRejectionBanner(prRejectionRate: _model.prRejectionRate),
            const SizedBox(height: 16.0),
            VideoFormatCard(
              model: _model,
              onValidateNewFile: _checkFile,
            ),
          ],
        ),
      ),
    );
  }
}
