import 'package:flutter/material.dart';
import 'widgets/paginated_mobile_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paginated Mobile Data Table',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BigQuery Paginated Table'),
          backgroundColor: Colors.blueGrey.shade100,
        ),
        body: const PaginatedMobileTable(),
      ),
    );
  }
}
