import 'package:flutter/material.dart';
import 'widgets/filter_dimension_carousel_widget_3515FEBFL002A02.dart';

void main() {
  runApp(const FilterCarouselApp3515FEBFL002A02());
}

class FilterCarouselApp3515FEBFL002A02 extends StatelessWidget {
  const FilterCarouselApp3515FEBFL002A02({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filter Dimensions App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const FilterDimensionCarouselWidget3515FEBFL002A02(),
    );
  }
}
