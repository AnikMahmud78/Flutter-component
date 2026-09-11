import 'package:flutter/material.dart';

class RatingStepIncrement3790CSIVW003A03 extends StatefulWidget {
  const RatingStepIncrement3790CSIVW003A03({super.key});

  @override
  State<RatingStepIncrement3790CSIVW003A03> createState() =>
      _RatingStepIncrement3790CSIVW003A03State();
}

class _RatingStepIncrement3790CSIVW003A03State
    extends State<RatingStepIncrement3790CSIVW003A03> {
  double _rating = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Rating Step Increment')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const ListTile(
          title: Text('3790CSIVW-003-A03'),
          subtitle: Text('Quantitative rating uses a 0.5 step increment.'),
        ),
        Slider(
          value: _rating,
          min: 0,
          max: 5,
          divisions: 10,
          label: _rating.toStringAsFixed(1),
          onChanged: (value) => setState(() => _rating = value),
        ),
        Text('Selected rating: ${_rating.toStringAsFixed(1)}'),
      ],
    ),
  );
}
