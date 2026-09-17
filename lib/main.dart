// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/shimmer_animation_card.dart';
import 'widgets/gpu_render_banner.dart';

void main() {
  runApp(const ShimmerAnimationScreenApp());
}

class ShimmerAnimationScreenApp extends StatelessWidget {
  const ShimmerAnimationScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPU Shimmer Animation (GEN-00990)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ShimmerAnimationScreen(),
    );
  }
}

class ShimmerAnimationScreen extends StatelessWidget {
  const ShimmerAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPU Shimmer Animation (GEN-00990)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            GpuRenderBanner(status: 'Pass', refreshRateFps: 60),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ShimmerAnimationCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
