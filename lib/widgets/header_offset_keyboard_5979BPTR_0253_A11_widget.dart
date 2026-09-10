import 'package:flutter/material.dart';

class HeaderOffsetKeyboard5979BPTR0253A11Widget extends StatefulWidget {
  const HeaderOffsetKeyboard5979BPTR0253A11Widget({super.key});

  @override
  State<HeaderOffsetKeyboard5979BPTR0253A11Widget> createState() =>
      _HeaderOffsetKeyboard5979BPTR0253A11WidgetState();
}

class _HeaderOffsetKeyboard5979BPTR0253A11WidgetState
    extends State<HeaderOffsetKeyboard5979BPTR0253A11Widget> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final hidden = keyboardOpen && _enabled;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: hidden ? 0 : 64,
              child: Transform.translate(
                offset: Offset(0, hidden ? -64 : 0),
                child: const SizedBox(
                  height: 64,
                  child: Center(child: Text('Contextual Form Header')),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SwitchListTile(
                    title: const Text('Enable header offset'),
                    value: _enabled,
                    onChanged: (value) => setState(() => _enabled = value),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Active text entry line',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
