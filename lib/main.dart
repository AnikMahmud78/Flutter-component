import 'package:flutter/material.dart';
import 'widgets/defensive_parsing_shell_widget_776FEBFL013A07.dart';

void main() {
  runApp(const DefensiveParsingApp776FEBFL013A07());
}

class DefensiveParsingApp776FEBFL013A07 extends StatelessWidget {
  const DefensiveParsingApp776FEBFL013A07({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Defensive Parsing App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const DefensiveParsingShellWidget776FEBFL013A07(),
    );
  }
}
