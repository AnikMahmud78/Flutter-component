import 'package:flutter/material.dart';
import 'models/skeleton_mimic_model.dart';
import 'widgets/skeleton_mimic_card.dart';

void main() {
  runApp(const SkeletonMimicApp());
}

class SkeletonMimicApp extends StatelessWidget {
  const SkeletonMimicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeleton Mimic Loader',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home: const SkeletonMimicScreen(),
    );
  }
}

class SkeletonMimicScreen extends StatefulWidget {
  const SkeletonMimicScreen({Key? key}) : super(key: key);

  @override
  State<SkeletonMimicScreen> createState() => _SkeletonMimicScreenState();
}

class _SkeletonMimicScreenState extends State<SkeletonMimicScreen> {
  SkeletonMimicModel _model = const SkeletonMimicModel(isLoading: true, completionRate: 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skeleton Loader Mimic')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SkeletonMimicCard(
              model: _model,
              onToggleLoading: () {
                setState(() {
                  _model = SkeletonMimicModel(isLoading: !_model.isLoading, completionRate: 100.0);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
