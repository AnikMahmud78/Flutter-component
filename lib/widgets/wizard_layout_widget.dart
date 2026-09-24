import 'package:flutter/material.dart';

class WizardLayoutWidget extends StatefulWidget {
  final int totalSteps;
  const WizardLayoutWidget({super.key, this.totalSteps = 4});

  @override
  State<WizardLayoutWidget> createState() => _WizardLayoutWidgetState();
}

class _WizardLayoutWidgetState extends State<WizardLayoutWidget> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(value: (_currentStep + 1) / widget.totalSteps),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 3.0,
              child: Center(
                child: Text('Step ${_currentStep + 1} Content', style: Theme.of(context).textTheme.headlineMedium),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                minWidth: 100,
                height: 48,
                child: OutlinedButton(
                  onPressed: _currentStep > 0 ? () => setState(() => _currentStep--) : null,
                  child: const Text('Previous'),
                ),
              ),
              SizedBox(
                minWidth: 100,
                height: 48,
                child: ElevatedButton(
                  onPressed: _currentStep < widget.totalSteps - 1 ? () => setState(() => _currentStep++) : null,
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
