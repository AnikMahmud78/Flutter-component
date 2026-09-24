import 'package:flutter/material.dart';
import 'models/history_card_model.dart';
import 'widgets/history_rating_prompt_card.dart';

void main() {
  runApp(const RatingPromptApp());
}

class RatingPromptApp extends StatelessWidget {
  const RatingPromptApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT History Rating Prompts',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)),
      home: const RatingPromptScreen(),
    );
  }
}

class RatingPromptScreen extends StatefulWidget {
  const RatingPromptScreen({Key? key}) : super(key: key);

  @override
  State<RatingPromptScreen> createState() => _RatingPromptScreenState();
}

class _RatingPromptScreenState extends State<RatingPromptScreen> {
  HistoryCardModel _item = const HistoryCardModel(
    serviceId: 'SRV-9532-88',
    serviceTitle: 'After-School Care & Transport',
    isCompleted: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History Service Prompts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HistoryRatingPromptCard(
              model: _item,
              onRateSelected: (rating) {
                setState(() {
                  _item = HistoryCardModel(
                    serviceId: _item.serviceId,
                    serviceTitle: _item.serviceTitle,
                    isCompleted: true,
                    rating: rating,
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Rating \$rating submitted! Telemetry synced.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
