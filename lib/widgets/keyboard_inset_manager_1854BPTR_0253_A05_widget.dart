import 'package:flutter/material.dart';

class KeyboardInsetManager1854BPTR0253A05Widget extends StatelessWidget {
  const KeyboardInsetManager1854BPTR0253A05Widget({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    return Scaffold(
      appBar: AppBar(title: const Text('Keyboard Inset Manager')),
      body: AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.only(bottom: inset),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Active inset: ${inset.toStringAsFixed(1)} dp'),
            const SizedBox(height: 240),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Lower form field',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
