import 'package:flutter/material.dart';
import 'widgets/paginated_table_limit_widget.dart';

void main() {
  runApp(const PaginatedTableLimitApp());
}

class PaginatedTableLimitApp extends StatelessWidget {
  const PaginatedTableLimitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paginated Table Limit App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const PaginatedTableLimitWidget(),
    );
  }
}
