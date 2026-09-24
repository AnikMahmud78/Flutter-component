import 'package:flutter/material.dart';
import 'models/single_execution_model.dart';
import 'widgets/single_execution_card.dart';

void main() {
  runApp(const SingleExecApp());
}

class SingleExecApp extends StatelessWidget {
  const SingleExecApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Single Exec Gate',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const SingleExecScreen(),
    );
  }
}

class SingleExecScreen extends StatefulWidget {
  const SingleExecScreen({Key? key}) : super(key: key);

  @override
  State<SingleExecScreen> createState() => _SingleExecScreenState();
}

class _SingleExecScreenState extends State<SingleExecScreen> {
  SingleExecutionModel _model = const SingleExecutionModel(hasExecuted: false, freCompletionRate: 0.92);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single Execution Enforcer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SingleExecutionCard(
              model: _model,
              onTriggerFirstRun: () {
                setState(() {
                  _model = const SingleExecutionModel(hasExecuted: true, freCompletionRate: 0.92);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('First-run execution completed and locked.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
