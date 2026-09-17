// lib/widgets/review_sentiment_card.dart
import 'package:flutter/material.dart';

class ReviewSentimentCard extends StatelessWidget {
  const ReviewSentimentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('App Store Sentiment Attribution Engine', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Worker Schedule: Every 4 Hours'),
          subtitle: const Text('Scrapes App Store & Google Play reviews for sentiment extraction'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.reviews),
            label: const Text('SCHEDULE SCRAPING & SENTIMENT RUN'),
          ),
        ),
      ],
    );
  }
}
