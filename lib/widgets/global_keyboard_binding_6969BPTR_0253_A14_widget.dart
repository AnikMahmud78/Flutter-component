import 'package:flutter/material.dart';

class GlobalKeyboardBinding6969BPTR0253A14Widget extends StatelessWidget {
  const GlobalKeyboardBinding6969BPTR0253A14Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Global View Inset Binding')),
      resizeToAvoidBottomInset: true,
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Inset-protected input 1',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Inset-protected input 2',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
