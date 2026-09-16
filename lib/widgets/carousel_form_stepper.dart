import 'package:flutter/material.dart';

class CarouselFormStepper extends StatefulWidget {
  final VoidCallback onSequenceComplete;

  const CarouselFormStepper({
    super.key,
    required this.onSequenceComplete,
  });

  @override
  State<CarouselFormStepper> createState() => _CarouselFormStepperState();
}

class _CarouselFormStepperState extends State<CarouselFormStepper> {
  final PageController _pageController = PageController();
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();

  int _currentStep = 0;
  final TextEditingController _step1Controller = TextEditingController();
  final TextEditingController _step2Controller = TextEditingController();

  void _nextStep() {
    FocusScope.of(context).unfocus(); // Auto dismiss system keyboard
    if (_currentStep == 0) {
      if (_step1Key.currentState!.validate()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
        );
      }
    } else if (_currentStep == 1) {
      if (_step2Key.currentState!.validate()) {
        widget.onSequenceComplete();
      }
    }
  }

  void _previousStep() {
    FocusScope.of(context).unfocus();
    _pageController.previousPage(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Block unvalidated swipes
            onPageChanged: (idx) => setState(() => _currentStep = idx),
            children: [
              _buildStepCard(
                formKey: _step1Key,
                title: 'Step 1: Account Context',
                child: TextFormField(
                  controller: _step1Controller,
                  decoration: const InputDecoration(
                    labelText: 'User Identifier',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Field required' : null,
                ),
              ),
              _buildStepCard(
                formKey: _step2Key,
                title: 'Step 2: Operational Data',
                child: TextFormField(
                  controller: _step2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Telemetry Metric Key',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Field required' : null,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 8.0,
              width: _currentStep == index ? 24.0 : 8.0,
              decoration: BoxDecoration(
                color: _currentStep == index ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(4.0),
              ),
            );
          }),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: SizedBox(
                  height: 48.0,
                  child: OutlinedButton(
                    onPressed: _previousStep,
                    child: const Text('BACK'),
                  ),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 12.0),
            Expanded(
              child: SizedBox(
                height: 48.0,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  child: Text(_currentStep == 1 ? 'FINALIZE' : 'NEXT STEP'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepCard({
    required GlobalKey<FormState> formKey,
    required String title,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
