import 'package:flutter/material.dart';
import 'widgets/material3_layout_scaffold_widget_4461FEBFL025A06.dart';

void main() {
  runApp(const Material3LayoutApp4461FEBFL025A06());
}

class Material3LayoutApp4461FEBFL025A06 extends StatelessWidget {
  const Material3LayoutApp4461FEBFL025A06({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material 3 Layout Scaffolds',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const Material3LayoutScaffoldWidget4461FEBFL025A06(),
    );
  }
}
