import 'package:flutter/material.dart';
import 'widgets/material_tokens_1744BPTR0544A12.dart';

void main() {
  runApp(const MaterialTokens1744BPTR0544A12App());
}

class MaterialTokens1744BPTR0544A12App extends StatelessWidget {
  const MaterialTokens1744BPTR0544A12App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Material Design Tokens',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const MaterialTokens1744BPTR0544A12(),
  );
}
