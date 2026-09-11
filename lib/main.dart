import 'package:flutter/material.dart';
import 'widgets/virtual_table_structure_4252CPNCA006A05.dart';

void main() {
  runApp(const VirtualTableStructure4252CPNCA006A05App());
}

class VirtualTableStructure4252CPNCA006A05App extends StatelessWidget {
  const VirtualTableStructure4252CPNCA006A05App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Virtual Data Table App',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const VirtualTableStructure4252CPNCA006A05(),
  );
}
