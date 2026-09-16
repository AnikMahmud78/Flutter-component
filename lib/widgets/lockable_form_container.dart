// lib/widgets/lockable_form_container.dart
// Task GEN-00079: Build LockableFormContainer Component
import 'package:flutter/material.dart';

class LockableFormContainer extends StatefulWidget {
  const LockableFormContainer({super.key});

  @override
  State<LockableFormContainer> createState() => _LockableFormContainerState();
}

class _LockableFormContainerState extends State<LockableFormContainer> {
  bool _isLocked = false;

  Future<void> _executeAsyncOperation() async {
    setState(() => _isLocked = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLocked = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        AbsorbPointer(
          absorbing: _isLocked,
          child: Opacity(
            opacity: _isLocked ? 0.6 : 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Protected Data Fields', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12.0),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48.0),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Lockable Input Payload',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 48.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48.0)),
                    onPressed: _executeAsyncOperation,
                    child: const Text('SUBMIT PROTECTED PAYLOAD'),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isLocked)
          Positioned.fill(
            child: Container(
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
