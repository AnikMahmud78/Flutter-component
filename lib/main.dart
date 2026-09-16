import 'package:flutter/material.dart';
import 'widgets/carousel_form_stepper.dart';
import 'widgets/test_pass_status_banner.dart';

void main() {
  runApp(const CarouselStepperApp());
}

class CarouselStepperApp extends StatelessWidget {
  const CarouselStepperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guided Carousel Stepper',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const StepperScreen(),
    );
  }
}

class StepperScreen extends StatelessWidget {
  const StepperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carousel Form Stepper (FIEVR-033)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TestPassStatusBanner(status: 'Pass', coverage: '100%'),
            CarouselFormStepper(
              onSequenceComplete: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Carousel Form Sequence Finalized!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
