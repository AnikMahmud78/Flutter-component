import 'package:flutter/material.dart';
import '../models/sop_video_compliance_model.dart';

class VideoFormatCard extends StatelessWidget {
  final SopVideoComplianceModel model;
  final VoidCallback onValidateNewFile;

  const VideoFormatCard({
    super.key,
    required this.model,
    required this.onValidateNewFile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SOP Asset ID: ${model.sopId}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('File Extension: .${model.fileExtension}', style: theme.textTheme.bodyMedium),
            Text('Is Compressed Format (MP4/WebM): ${model.isCompressedFormat ? "YES" : "NO"}'),
            Text('Compliance Level: ${model.complianceStatus.name.toUpperCase()}'),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: OutlinedButton(
                onPressed: onValidateNewFile,
                style: OutlinedButton.styleFrom(minimumSize: const Size(48, 48)),
                child: const Text('Re-scan Video Artifacts'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
