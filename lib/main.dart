import 'package:flutter/material.dart';
import 'widgets/exception_card_display_widget_6848ETMDI02113.dart';

void main() {
  runApp(const ExceptionCardApp6848ETMDI02113());
}

class ExceptionCardApp6848ETMDI02113 extends StatelessWidget {
  const ExceptionCardApp6848ETMDI02113({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exception Display Cards App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const ExceptionCardDisplayWidget6848ETMDI02113(),
    );
  }
}
