import 'package:flutter/material.dart';

class PokaYokeButtonGuard extends StatelessWidget {
  final bool isDataProvided;
  final VoidCallback onNextPressed;

  const PokaYokeButtonGuard({
    super.key,
    required this.isDataProvided,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: isDataProvided ? onNextPressed : null,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
        ),
        child: Text(isDataProvided ? 'Next Step' : 'Provide Required Data to Proceed'),
      ),
    );
  }
}
