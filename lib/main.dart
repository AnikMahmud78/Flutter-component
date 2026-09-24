import 'package:flutter/material.dart';
import 'models/token_compiler_model.dart';
import 'widgets/token_compiler_card.dart';

void main() {
  runApp(const TokenCompilerApp());
}

class TokenCompilerApp extends StatelessWidget {
  const TokenCompilerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Design Token Compiler',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const TokenCompilerScreen(),
    );
  }
}

class TokenCompilerScreen extends StatefulWidget {
  const TokenCompilerScreen({Key? key}) : super(key: key);

  @override
  State<TokenCompilerScreen> createState() => _TokenCompilerScreenState();
}

class _TokenCompilerScreenState extends State<TokenCompilerScreen> {
  TokenCompilerModel _model = const TokenCompilerModel(
    compilationJobId: 'JOB-W3C-9587',
    successRate: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Token Compiler')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TokenCompilerCard(
              model: _model,
              onCompile: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('CSS Tokens Compiled (100% W3C Pass)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
