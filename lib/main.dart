import 'package:flutter/material.dart';
import 'widgets/masked_card_input.dart';
import 'widgets/numeric_routed_input_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Numeric Keypad Routing Engine',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const NumericEngineScreen(),
    );
  }
}

class NumericEngineScreen extends StatefulWidget {
  const NumericEngineScreen({super.key});

  @override
  State<NumericEngineScreen> createState() => _NumericEngineScreenState();
}

class _NumericEngineScreenState extends State<NumericEngineScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // Validation States
  bool _isCardValid = false;
  String? _amountError;

  void _validateCard(String value) {
    final rawDigits = value.replaceAll(' ', '');
    setState(() {
      _isCardValid = rawDigits.length == 16;
    });
  }

  void _validateAmount(String value) {
    setState(() {
      if (value.isEmpty) {
        _amountError = 'Amount is required.';
      } else if (double.tryParse(value) == null || double.parse(value) <= 0) {
        _amountError = 'Enter a valid payment amount greater than \$0.00';
      } else {
        _amountError = null; // Valid
      }
    });
  }

  bool get _isFormValid =>
      _isCardValid && _amountError == null && _amountController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Numeric Keypad Routing Engine')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Checkout Form',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 1. MASKED CARD INPUT
              MaskedCardInput(
                controller: _cardController,
                onChanged: _validateCard,
                isValid: _isCardValid,
              ),

              const SizedBox(height: 20),

              // 2. NUMERIC KEYPAD ROUTED FIELD (CURRENCY)
              NumericRoutedInputField(
                controller: _amountController,
                label: 'Payment Amount (\$)',
                hintText: '0.00',
                helperText: 'Enter numerical transaction amount (e.g. 50.25)',
                errorText: _amountError,
                isDecimalAllowed: true,
                onChanged: _validateAmount,
              ),

              const SizedBox(height: 32),

              // SUBMIT BUTTON (Locked until all numeric pattern schemas pass)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isFormValid
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Transaction Payload Cleared & Submitted!',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: const Text(
                    'Submit Transaction',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
