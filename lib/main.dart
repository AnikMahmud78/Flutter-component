// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/m3_surface_container.dart';
import 'widgets/m3_surface_banner.dart';

void main() {
  runApp(const SurfaceApp());
}

class SurfaceApp extends StatelessWidget {
  const SurfaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MD3 Surface Standardization',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SurfaceScreen(),
    );
  }
}

class SurfaceScreen extends StatelessWidget {
  const SurfaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MD3 Surface Standards (GEN-00856)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            M3SurfaceBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: M3SurfaceContainer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
