import 'package:flutter/material.dart';
import '../models/history_card_model.dart';

class HistoryRatingPromptCard extends StatelessWidget {
  final HistoryCardModel model;
  final ValueChanged<int> onRateSelected;

  const HistoryRatingPromptCard({
    Key? key,
    required this.model,
    required this.onRateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.serviceTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text('Service Status: Completed', style: theme.textTheme.bodySmall),
            const Divider(height: 24.0),
            Text('How was your experience?', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                final starValue = index + 1;
                return SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      starValue <= (model.rating ?? 0) ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32.0,
                    ),
                    onPressed: () => onRateSelected(starValue),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
