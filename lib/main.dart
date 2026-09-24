import 'package:flutter/material.dart';
import 'widgets/m3_focus_ring_wrapper.dart';

void main() {
  runApp(const FocusRingApp());
}

class FocusRingApp extends StatelessWidget {
  const FocusRingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(title: const Text('M3 Focus Ring Console')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: M3FocusRingWrapper(
              onTap: () {},
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('FOCUSABLE INTERACTIVE CONTROL'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
