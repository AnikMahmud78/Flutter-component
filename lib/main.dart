import 'dart:async';
import 'package:flutter/material.dart';
import 'models/countdown_model.dart';
import 'widgets/countdown_clock_widget.dart';

void main() {
  runApp(const CountdownClockApp());
}

class CountdownClockApp extends StatelessWidget {
  const CountdownClockApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Countdown Timer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const CountdownScreen(),
    );
  }
}

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  static const int _initialSeconds = 300;
  int _secondsLeft = _initialSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = _initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = CountdownModel(
      totalSeconds: _initialSeconds,
      remainingSeconds: _secondsLeft,
      isExpired: _secondsLeft == 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Session Window'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CountdownClockWidget(model: model),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _startTimer,
          child: const Text('Reset 5-Minute Window'),
        ),
      ),
    );
  }
}
