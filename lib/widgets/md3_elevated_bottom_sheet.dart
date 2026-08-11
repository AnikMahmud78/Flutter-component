import 'package:flutter/material.dart';
import '../models/login_form_state.dart';

class Md3ElevatedBottomSheet extends StatefulWidget {
  const Md3ElevatedBottomSheet({super.key});

  /// Static trigger helper launching the MD3 Elevated Bottom Sheet
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      elevation: 8.0, // MD3 Elevated Surface Token
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28.0),
        ), // MD3 Rounded Top Corners
      ),
      builder: (context) => const Md3ElevatedBottomSheet(),
    );
  }

  @override
  State<Md3ElevatedBottomSheet> createState() => _Md3ElevatedBottomSheetState();
}

class _Md3ElevatedBottomSheetState extends State<Md3ElevatedBottomSheet> {
  final LoginFormState _formState = LoginFormState();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      // REQUIREMENT: Prevent soft keyboard layout overlap
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16.0), // REQUIREMENT: 16px Grid Margins
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MD3 Central Drag Handle
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const Text(
              'Express Authentication',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Single focus view — Fill mandatory fields to continue.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),

            // FIELD 1: EMAIL (Full-width, red asterisk, >=48px height)
            _buildMandatoryLabel('Email Address'),
            const SizedBox(height: 6),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              initialValue: _formState.email,
              onChanged: (val) => setState(() => _formState.email = val),
              decoration: const InputDecoration(
                hintText: 'user@domain.com',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ), // >=48px Touch Target
              ),
            ),

            const SizedBox(height: 16),

            // FIELD 2: ACCOUNT PASSWORD (Full-width, red asterisk, >=48px height)
            _buildMandatoryLabel('Account Password'),
            const SizedBox(height: 6),
            TextFormField(
              obscureText: true,
              initialValue: _formState.password,
              onChanged: (val) => setState(() => _formState.password = val),
              decoration: const InputDecoration(
                hintText: 'Enter password (min 6 chars)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ), // >=48px Touch Target
              ),
            ),

            const SizedBox(height: 24),

            // ACTION BUTTON (Full-width, >=48px Touch Target Height)
            SizedBox(
              width: double.infinity,
              height: 48, // REQUIREMENT: >=48px Touch Target
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _formState.isFormValid
                    ? () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Authentication Successful!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    : null,
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // REQUIREMENT: Mark mandatory fields with a red asterisk (*)
  Widget _buildMandatoryLabel(String label) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(width: 4),
        const Text(
          '*',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
