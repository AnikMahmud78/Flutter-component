import 'package:flutter/material.dart';
import 'widgets/mtoi_embedded_video_card.dart';

void main() {
  runApp(const MtoiTrainingApp());
}

class MtoiTrainingApp extends StatelessWidget {
  const MtoiTrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MTOI Embedded Video Training',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const MtoiEmbeddedVideoCard(),
    );
  }
}
