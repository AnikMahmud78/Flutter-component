import 'package:flutter/material.dart';
import '../models/onboarding_step.dart';

/// Contextual Interactive Guidance Overlay Widget
class OperatorWalkthroughOverlay extends StatefulWidget {
  final List<OnboardingStep> steps;
  final VoidCallback onCompleted;
  final VoidCallback onSkipped;

  const OperatorWalkthroughOverlay({
    super.key,
    required this.steps,
    required this.onCompleted,
    required this.onSkipped,
  });

  @override
  State<OperatorWalkthroughOverlay> createState() =>
      _OperatorWalkthroughOverlayState();
}

class _OperatorWalkthroughOverlayState
    extends State<OperatorWalkthroughOverlay> {
  int _currentStepIndex = 0;

  Rect? _getTargetRect(GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    return position & size;
  }

  void _nextStep() {
    if (_currentStepIndex < widget.steps.length - 1) {
      setState(() {
        _currentStepIndex++;
      });
    } else {
      widget.onCompleted();
    }
  }

  void _previousStep() {
    if (_currentStepIndex > 0) {
      setState(() {
        _currentStepIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = widget.steps[_currentStepIndex];
    final targetRect = _getTargetRect(currentStep.targetKey);

    return Stack(
      children: [
        // Darkened background backdrop with cut-out hole for active element
        Positioned.fill(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(180),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                if (targetRect != null)
                  Positioned(
                    left: targetRect.left - 6,
                    top: targetRect.top - 6,
                    width: targetRect.width + 12,
                    height: targetRect.height + 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Contextual Guidance Tooltip Card
        Align(
          alignment: currentStep.cardAlignment,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: Container(
                width: 320,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Badge & Progress
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Step ${_currentStepIndex + 1} of ${widget.steps.length}',
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onSkipped,
                          child: const Text(
                            'Skip Tour',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Guidance Title & Description
                    Text(
                      currentStep.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      currentStep.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Navigation Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentStepIndex > 0)
                          OutlinedButton(
                            onPressed: _previousStep,
                            child: const Text('Back'),
                          )
                        else
                          const SizedBox.shrink(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _nextStep,
                          child: Text(
                            _currentStepIndex == widget.steps.length - 1
                                ? 'Finish Tour'
                                : 'Next',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
