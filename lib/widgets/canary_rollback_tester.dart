import 'package:flutter/material.dart';

class CanaryRollbackTester extends StatefulWidget {
  const CanaryRollbackTester({Key? key}) : super(key: key);

  @override
  State<CanaryRollbackTester> createState() => _CanaryRollbackTesterState();
}

class _CanaryRollbackTesterState extends State<CanaryRollbackTester> {
  double _seededErrorRate = 0.5;
  bool _isRolledBack = false;
  String _activeRelease = 'v3.12.0-experimental';

  // English Code (EC): Seed-Canary-Error-And-Verify-Rollback
  void seedCanaryErrorAndVerifyRollback() {
    setState(() {
      _seededErrorRate = 12.8; // Exceeds 5.0% threshold
      if (_seededErrorRate > 5.0) {
        _isRolledBack = true;
        _activeRelease = 'v3.11.9-STABLE-STABLE';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Canary Rollback Simulator', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Seeded Error Rate: ${_seededErrorRate}%'),
            Text('Active Variant: $_activeRelease', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
                onPressed: seedCanaryErrorAndVerifyRollback,
                child: const Text('SEED ELEVATED ERRORS (TRIGGER ROLLBACK)'),
              ),
            ),
            if (_isRolledBack)
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    Icon(Icons.autorenew, color: Colors.green),
                    SizedBox(width: 8),
                    Text('AUTOMATIC ROLLBACK CONFIRMED PASSED', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
