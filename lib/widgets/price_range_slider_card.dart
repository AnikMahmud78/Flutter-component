import 'package:flutter/material.dart';
import '../models/price_range_model.dart';

class PriceRangeSliderCard extends StatelessWidget {
  final PriceRangeModel model;
  final ValueChanged<RangeValues> RangeChanged;

  const PriceRangeSliderCard({
    Key? key,
    required this.model,
    required this.RangeChanged,
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
            Text('Price Range Filter', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8.0),
            Text(
              '\\$\${model.minPrice.round()} - \\$\${model.maxPrice.round()}',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            RangeSlider(
              values: RangeValues(model.minPrice, model.maxPrice),
              min: 0.0,
              max: 500.0,
              divisions: 50,
              labels: RangeLabels(
                '\\$\${model.minPrice.round()}',
                '\\$\${model.maxPrice.round()}',
              ),
              onChanged: RangeChanged,
            ),
          ],
        ),
      ),
    );
  }
}
