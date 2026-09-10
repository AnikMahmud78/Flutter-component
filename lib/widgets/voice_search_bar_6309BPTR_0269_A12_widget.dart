import 'package:flutter/material.dart';

class VoiceSearchBar6309BPTR0269A12Widget extends StatefulWidget {
  const VoiceSearchBar6309BPTR0269A12Widget({super.key});

  @override
  State<VoiceSearchBar6309BPTR0269A12Widget> createState() =>
      _VoiceSearchBar6309BPTR0269A12WidgetState();
}

class _VoiceSearchBar6309BPTR0269A12WidgetState
    extends State<VoiceSearchBar6309BPTR0269A12Widget> {
  bool _listening = false;
  String _query = '';

  void _listen() {
    setState(() => _listening = true);
    Future<void>.delayed(const Duration(milliseconds: 120), () {
      if (!mounted) return;
      setState(() {
        _listening = false;
        _query = 'Clinical Speech Pathologist';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Search Bar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: _listening
                    ? 'Listening...'
                    : 'Speak or type to search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(_listening ? Icons.graphic_eq : Icons.mic),
                  onPressed: _listen,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            if (_query.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Filter query: $_query'),
              ),
          ],
        ),
      ),
    );
  }
}
