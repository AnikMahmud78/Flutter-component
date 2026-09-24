import 'package:flutter/material.dart';
import 'models/byt_image_model.dart';
import 'widgets/zoomable_byt_image.dart';

void main() {
  runApp(const ZoomableBytApp());
}

class ZoomableBytApp extends StatelessWidget {
  const ZoomableBytApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Byt Image Pinch-to-Zoom',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const BytImageScreen(),
    );
  }
}

class BytImageScreen extends StatelessWidget {
  const BytImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bytModel = BytImageModel(
      imageId: 'BYT-CROP-8821',
      imageUrl: 'https://placeholder.co/600x400',
      minScale: 1.0,
      maxScale: 4.0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Worker Inspection')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Inspection Artifact: ${bytModel.imageId}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Pinch or double-finger gesture to zoom image:'),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: ZoomableBytImage(model: bytModel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
