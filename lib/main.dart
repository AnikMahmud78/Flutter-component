// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/review_sentiment_card.dart';
import 'widgets/sentiment_schedule_banner.dart';

void main() {
  runApp(const ReviewSentimentScreenApp());
}

class ReviewSentimentScreenApp extends StatelessWidget {
  const ReviewSentimentScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review Sentiment Engine (GEN-00945)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ReviewSentimentScreen(),
    );
  }
}

class ReviewSentimentScreen extends StatelessWidget {
  const ReviewSentimentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Sentiment Engine (GEN-00945)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SentimentScheduleBanner(status: 'Pass', intervalHours: 4),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ReviewSentimentCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
