import 'package:flutter/material.dart';
import 'models/fluid_scaling_model.dart';
import 'services/fluid_text_utility.dart';
import 'widgets/fluid_text_card.dart';
import 'widgets/scaling_banner.dart';

void main() {
  runApp(const HABOTFluidApp());
}

class HABOTFluidApp extends StatelessWidget {
  const HABOTFluidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10291GEN-02062 Fluid Scaling',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A6267)),
      ),
      home: const FluidScreen(),
    );
  }
}

class FluidScreen extends StatelessWidget {
  const FluidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final FluidScalingModel model = FluidTextUtility.evaluateFluidState(
      taskId: '10291GEN-02062',
      viewportWidth: width,
      userId: 'USER-ANIK-8821',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Fluid Text Scaling Engine')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ScalingBanner(rate: model.completionRate),
            const SizedBox(height: 16.0),
            FluidTextCard(model: model),
          ],
        ),
      ),
    );
  }
}
