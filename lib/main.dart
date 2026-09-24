import 'package:flutter/material.dart';
import 'models/task_time_gate_model.dart';
import 'widgets/task_time_gate_card.dart';

void main() {
  runApp(const TaskTimeGateApp());
}

class TaskTimeGateApp extends StatelessWidget {
  const TaskTimeGateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Time Gate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const TaskTimeGateScreen(),
    );
  }
}

class TaskTimeGateScreen extends StatefulWidget {
  const TaskTimeGateScreen({Key? key}) : super(key: key);

  @override
  State<TaskTimeGateScreen> createState() => _TaskTimeGateScreenState();
}

class _TaskTimeGateScreenState extends State<TaskTimeGateScreen> {
  TaskTimeGateModel _model = const TaskTimeGateModel(
    maxTaskSeconds: 300,
    elapsedSeconds: 120,
    prRejectionRate: 99.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Physical Time Boundary Gate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TaskTimeGateCard(
              model: _model,
              onCheckTimer: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Time Cap Enforced (Within 300s Limit)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
