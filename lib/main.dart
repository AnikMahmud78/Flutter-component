// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/fre_carousel_card.dart';
import 'widgets/fre_completion_banner.dart';

void main() {
  runApp(const FreCarouselScreenApp());
}

class FreCarouselScreenApp extends StatelessWidget {
  const FreCarouselScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FRE Carousel (GEN-01112)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const FreCarouselScreen(),
    );
  }
}

class FreCarouselScreen extends StatelessWidget {
  const FreCarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FRE Carousel (GEN-01112)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FreCompletionBanner(status: 'Good', completionRate: 0.9),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FreCarouselCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
