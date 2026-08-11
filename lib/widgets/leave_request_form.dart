import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({super.key});

  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm>
    with SingleTickerProviderStateMixin {
  // REQUIREMENT: Permanent Leave Balance
  final int _currentLeaveBalance = 12; // 12 Days Available

  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  String? _errorMessage;
  bool _shouldShake = false;

  @override
  void initState() {
    super.initState();
    // Setup 400ms tactile shake animation sequence
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _shakeAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -12.0), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -12.0, end: 12.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 12.0, end: -12.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -12.0, end: 12.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 12.0, end: 0.0), weight: 1),
        ]).animate(
          CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _daysController.dispose();
    _reasonController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _triggerShakeAnimation() {
    _shakeController.forward(from: 0.0);
  }

  void _validateInput(String value) {
    if (value.isEmpty) {
      setState(() {
        _errorMessage = null;
        _shouldShake = false;
      });
      return;
    }

    final int? requestedDays = int.tryParse(value);

    if (requestedDays == null || requestedDays <= 0) {
      setState(() {
        _errorMessage = 'Please enter a valid number of days.';
      });
    } else if (requestedDays > _currentLeaveBalance) {
      // REQUIREMENT: Trigger instant visual feedback (shake animation) when exceeding balance
      setState(() {
        _errorMessage =
            'Requested leave ($requestedDays days) exceeds available balance ($_currentLeaveBalance days).';
      });
      _triggerShakeAnimation();
    } else {
      // Valid input within balance limits
      setState(() {
        _errorMessage = null;
      });
    }
  }

  bool get _isFormValid {
    final int? days = int.tryParse(_daysController.text);
    return days != null &&
        days > 0 &&
        days <= _currentLeaveBalance &&
        _errorMessage == null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- REQUIREMENT: PERMANENT LEAVE BALANCE DISPLAY ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: Colors.blue.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Leave Balance',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          '$_currentLeaveBalance Days Available',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Annual Leave',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Leave Request Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // --- REQUESTED DAYS INPUT FIELD WITH SHAKE ANIMATION WRAPPER ---
          AnimatedBuilder(
            animation: _shakeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_shakeAnimation.value, 0),
                child: child,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _daysController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: _validateInput,
                  decoration: InputDecoration(
                    labelText: 'Requested Days',
                    hintText: 'Enter number of days (e.g. 3)',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _errorMessage != null
                            ? Colors.red.shade700
                            : Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _errorMessage != null
                            ? Colors.red.shade700
                            : Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: Icon(
                      _errorMessage != null
                          ? Icons.error_outline
                          : (_isFormValid
                                ? Icons.check_circle
                                : Icons.event_note),
                      color: _errorMessage != null
                          ? Colors.red.shade700
                          : (_isFormValid ? Colors.green : Colors.grey),
                    ),
                  ),
                ),

                // --- REQUIREMENT: BRIGHT RED SEMANTIC TEXT FOR ERROR EXPLANATIONS ---
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 12.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // REASON FOR LEAVE INPUT
          TextFormField(
            controller: _reasonController,
            decoration: const InputDecoration(
              labelText: 'Reason for Leave',
              hintText: 'e.g. Personal errand / Vacation',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 28),

          // --- REQUIREMENT: GREYED-OUT DISABLED SUBMIT BUTTON IF BALANCE EXCEEDED ---
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              // Button is set to null (unclickable) when validation fails or balance is exceeded
              onPressed: _isFormValid
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Leave Request Submitted Successfully!',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                // Greyed-out disabled styling properties
                disabledBackgroundColor: Colors.grey.shade300,
                disabledForegroundColor: Colors.grey.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _isFormValid
                    ? 'Submit Leave Request'
                    : 'Submit Disabled (Exceeds Balance)',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
