import 'package:flutter/material.dart';
import 'widgets/keyboard_anchored_menu.dart';

void main() {
  runApp(const KeyboardAnimationApp());
}

class KeyboardAnimationApp extends StatelessWidget {
  const KeyboardAnimationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard Anchored Slash Menu',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const KeyboardScreen(),
    );
  }
}

class KeyboardScreen extends StatefulWidget {
  const KeyboardScreen({Key? key}) : super(key: key);

  @override
  State<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isMenuOpen = false;

  void _onTextChanged(String text) {
    setState(() {
      _isMenuOpen = text.endsWith('/');
    });
  }

  void _handleCommand(String cmd) {
    _controller.text = '${_controller.text}$cmd ';
    setState(() => _isMenuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slash Command Animation')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              onChanged: _onTextChanged,
              decoration: const InputDecoration(
                hintText: 'Type / to trigger slash menu...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          KeyboardAnchoredMenu(
            isOpen: _isMenuOpen,
            onCommandSelected: _handleCommand,
          ),
        ],
      ),
    );
  }
}
