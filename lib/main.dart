import 'package:flutter/material.dart';
import 'models/price_range_model.dart';
import 'widgets/price_range_slider_card.dart';

void main() {
  runApp(const PriceSliderApp());
}

class PriceSliderApp extends StatelessWidget {
  const PriceSliderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Range Filter',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
      home: const PriceSliderScreen(),
    );
  }
}

class PriceSliderScreen extends StatefulWidget {
  const PriceSliderScreen({Key? key}) : super(key: key);

  @override
  State<PriceSliderScreen> createState() => _PriceSliderScreenState();
}

class _PriceSliderScreenState extends State<PriceSliderScreen> {
  PriceRangeModel _model = const PriceRangeModel(minPrice: 50.0, maxPrice: 250.0, latencyMs: 120);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filter Controls')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PriceRangeSliderCard(
              model: _model,
              RangeChanged: (newValues) {
                setState(() {
                  _model = PriceRangeModel(
                    minPrice: newValues.start,
                    maxPrice: newValues.end,
                    latencyMs: 110,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
