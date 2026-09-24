import 'package:flutter/material.dart';

class AutoFocusSearchBar extends StatefulWidget {
  const AutoFocusSearchBar({super.key});

  @override
  State<AutoFocusSearchBar> createState() => _AutoFocusSearchBarState();
}

class _AutoFocusSearchBarState extends State<AutoFocusSearchBar> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        focusNode: _focusNode,
        onTap: () => _focusNode.requestFocus(),
        decoration: InputDecoration(
          hintText: 'Search engineering components...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
      ),
    );
  }
}
