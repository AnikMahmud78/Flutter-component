import 'package:flutter/material.dart';
import 'widgets/bank_data_formatting_1040BPTR0633A11.dart';

void main() {
  runApp(const BankDataFormatting1040BPTR0633A11App());
}

class BankDataFormatting1040BPTR0633A11App extends StatelessWidget {
  const BankDataFormatting1040BPTR0633A11App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Bank Data Entry Validation',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const BankDataFormatting1040BPTR0633A11(),
  );
}
