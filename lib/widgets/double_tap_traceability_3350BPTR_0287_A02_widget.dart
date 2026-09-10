import 'package:flutter/material.dart';

class DoubleTapTraceability3350BPTR0287A02Widget extends StatelessWidget {
  const DoubleTapTraceability3350BPTR0287A02Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Double-tap mapping verified')),
      ),
      child: const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('SRC-LIST-ROW-ITEM-88 -> TGT-ACTION-TOGGLE-FAVORITE'),
        ),
      ),
    );
  }
}
