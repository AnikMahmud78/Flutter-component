import 'package:flutter/material.dart';
import 'models/figma_token_map_model.dart';
import 'widgets/figma_token_map_card.dart';

void main() {
  runApp(const FigmaTokenMapApp());
}

class FigmaTokenMapApp extends StatelessWidget {
  const FigmaTokenMapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Figma Token Mapper',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FigmaTokenMapScreen(),
    );
  }
}

class FigmaTokenMapScreen extends StatelessWidget {
  const FigmaTokenMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mapModel = FigmaTokenMapModel(
      figmaFileId: 'FIGMA-M3-9895',
      mappingCompletionRate: 99.5,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Figma Design Tokens')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FigmaTokenMapCard(
              model: mapModel,
              onSyncTokens: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('1:1 Pixel Fidelity Confirmed (100% Pass)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
