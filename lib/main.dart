import 'package:flutter/material.dart';
import 'widgets/leave_request_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leave Request Validation',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HR Leave Portal'),
          backgroundColor: Colors.blue.shade50,
        ),
        body: const LeaveRequestForm(),
      ),
    );
  }
}
