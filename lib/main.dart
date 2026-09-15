import 'package:flutter/material.dart';
import 'widgets/repo_connection_verifier_widget_2052FEBFL005A07.dart';

void main() {
  runApp(const RepoVerifierApp2052FEBFL005A07());
}

class RepoVerifierApp2052FEBFL005A07 extends StatelessWidget {
  const RepoVerifierApp2052FEBFL005A07({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Repo Connection Verifier App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const RepoConnectionVerifierWidget2052FEBFL005A07(),
    );
  }
}
