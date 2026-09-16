import 'package:flutter/material.dart';

class ShaktiAlertPanel extends StatefulWidget {
  final Widget child;

  const ShaktiAlertPanel({super.key, required this.child});

  @override
  State<ShaktiAlertPanel> createState() => _ShaktiAlertPanelState();
}

class _ShaktiAlertPanelState extends State<ShaktiAlertPanel> {
  bool _isPanelActive = true;
  final TextEditingController _clearanceTokenCtrl = TextEditingController();

  void _authenticateClearance() {
    if (_clearanceTokenCtrl.text.trim() == 'AUTH-CLEARANCE-2026') {
      setState(() => _isPanelActive = false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Clearance Token! Access Denied.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        widget.child,
        if (_isPanelActive)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              elevation: 24,
              color: Colors.red.shade900,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: Colors.white, size: 32),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'SHAKTI ALERT: P1 CRITICAL SYSTEM BREACH DETECTED',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _clearanceTokenCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Enter Authenticated System Clearance Token',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 48.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red.shade900,
                            minimumSize: const Size(double.infinity, 48.0),
                          ),
                          onPressed: _authenticateClearance,
                          child: const Text('SUBMIT AUTHENTICATED CLEARANCE'),
                        ),
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
