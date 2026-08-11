import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/atomic_step_state.dart';

class DeconstructedWizardScreen extends StatefulWidget {
  const DeconstructedWizardScreen({super.key});

  @override
  State<DeconstructedWizardScreen> createState() =>
      _DeconstructedWizardScreenState();
}

class _DeconstructedWizardScreenState extends State<DeconstructedWizardScreen> {
  int _currentStep = 1;
  final int _totalSteps = 3;

  final AtomicStepState _stateData = AtomicStepState();

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String? _step1Error;
  String? _step2Error;

  @override
  void dispose() {
    _userIdController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // --- STEP NAVIGATORS WITH GRANULARITY VALIDATION ---
  void _nextStep() {
    if (_currentStep == 1) {
      if (!_stateData.isStep1Valid) {
        setState(() {
          // REQUIREMENT: Enforce sentence-case labels on error prompts
          _step1Error = 'User identifier must be at least 4 characters long.';
        });
        return;
      }
      setState(() => _step1Error = null);
    } else if (_currentStep == 2) {
      if (!_stateData.isStep2Valid) {
        setState(() {
          // REQUIREMENT: Sentence-case error label
          _step2Error = 'Enter a valid positive transaction amount.';
        });
        return;
      }
      setState(() => _step2Error = null);
    }

    if (_currentStep < _totalSteps) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atomic Ingestion Wizard'),
        backgroundColor: Colors.blue.shade50,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // --- COMPACT VIEWPORT PROGRESS BAR ---
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step $_currentStep of $_totalSteps',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '${((_currentStep / _totalSteps) * 100).round()}% Completed',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentStep / _totalSteps,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),

            // --- DECONSTRUCTED SINGLE-INPUT UI SCREEN CONTAINER ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildCurrentSingleInputScreen(theme),
              ),
            ),

            // --- BOTTOM NAVIGATION ACTION BAR ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 6,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 1)
                    OutlinedButton(
                      onPressed: _previousStep,
                      child: const Text('Back'),
                    )
                  else
                    const SizedBox.shrink(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(120, 48), // 48dp Touch Target
                    ),
                    onPressed: _currentStep == _totalSteps
                        ? (_stateData.isStep3Valid
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Workflow Executed Successfully!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              : null)
                        : _nextStep,
                    child: Text(
                      _currentStep == _totalSteps
                          ? 'Submit Execution'
                          : 'Continue',
                      style: const TextStyle(fontWeight: FontWeight.bold),
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

  Widget _buildCurrentSingleInputScreen(ThemeData theme) {
    switch (_currentStep) {
      // =========================================================
      // SCREEN 1: DECONSTRUCTED SINGLE-INPUT -> USER IDENTITY
      // =========================================================
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Identify Operator',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Enter your authorized system user identification code.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: 'User ID',
                hintText: 'e.g. USER-2026-ANIK',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _step1Error != null
                        ? theme.colorScheme.error
                        : Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (val) {
                _stateData.userId = val;
                if (_step1Error != null) setState(() => _step1Error = null);
              },
            ),
            if (_step1Error != null) ...[
              const SizedBox(height: 12),
              // REQUIREMENT: Bound to on-error-container color token
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: theme.colorScheme.onErrorContainer,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _step1Error!,
                        style: TextStyle(
                          color: theme.colorScheme.onErrorContainer,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );

      // =========================================================
      // SCREEN 2: DECONSTRUCTED SINGLE-INPUT -> PAYLOAD AMOUNT
      // =========================================================
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaction Amount',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Specify the numerical transaction value for this step.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                labelText: 'Payload Amount (\$)',
                hintText: '0.00',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _step2Error != null
                        ? theme.colorScheme.error
                        : Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (val) {
                _stateData.payloadAmount = double.tryParse(val) ?? 0.0;
                if (_step2Error != null) setState(() => _step2Error = null);
              },
            ),
            if (_step2Error != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: theme.colorScheme.onErrorContainer,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _step2Error!,
                        style: TextStyle(
                          color: theme.colorScheme.onErrorContainer,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );

      // =========================================================
      // SCREEN 3: DECONSTRUCTED SINGLE-INPUT -> EXECUTION CONFIRM
      // =========================================================
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm Action Execution',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Review extracted attributes before triggering final execution.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Summary Card
            Card(
              color: Colors.blueGrey.shade900,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Operator ID:',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        Text(
                          _stateData.userId,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.white24, height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Transaction Amount:',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        Text(
                          '\$${_stateData.payloadAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Single Confirmation Checkbox Input
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: Colors.blue.shade800,
              title: const Text(
                'I confirm that the above atomic data parameters are verified and compliant.',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              value: _stateData.isConfirmed,
              onChanged: (val) {
                setState(() {
                  _stateData.isConfirmed = val ?? false;
                });
              },
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
