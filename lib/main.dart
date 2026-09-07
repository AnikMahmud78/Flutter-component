import 'package:flutter/material.dart';
import 'widgets/pagination_wiring_widget.dart';

void main() {
  runApp(const PaginationWiringApp());
}

class PaginationWiringApp extends StatelessWidget {
  const PaginationWiringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagination Wiring App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const PaginationWiringWidget(),
    );
  }
}
