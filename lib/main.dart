import 'package:flutter/material.dart';
import 'models/zero_zoom_model.dart';
import 'widgets/zero_zoom_card.dart';

void main() {
  runApp(const ZeroZoomApp());
}

class ZeroZoomApp extends StatelessWidget {
  const ZeroZoomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zero-Zoom Viewport App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const ZeroZoomScreen(),
    );
  }
}

class ZeroZoomScreen extends StatelessWidget {
  const ZeroZoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const zeroZoomModel = ZeroZoomModel(isFitToViewport: true, completionRate: 100.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Zero-Zoom Layout Engine')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ZeroZoomCard(
              model: zeroZoomModel,
              onVerifyLayout: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Layout Fits Viewport (Zero Zoom/Scroll Required)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
