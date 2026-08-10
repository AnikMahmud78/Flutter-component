import 'package:flutter/material.dart';
import 'ergonomic_touch_target.dart';

class TouchSpacingDemo extends StatefulWidget {
  const TouchSpacingDemo({super.key});

  @override
  State<TouchSpacingDemo> createState() => _TouchSpacingDemoState();
}

class _TouchSpacingDemoState extends State<TouchSpacingDemo> {
  bool _debugTouchTargets = true;
  bool _optInEmail = false;
  bool _optInSms = false;

  void _showTapToast(String targetName) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Activated: $targetName (48x48dp Hit Zone)'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.blue.shade800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACTS 48x48dp Touch Targets'),
        backgroundColor: Colors.blue.shade50,
        actions: [
          Row(
            children: [
              const Text('Show Target Boxes', style: TextStyle(fontSize: 12)),
              Switch(
                value: _debugTouchTargets,
                onChanged: (val) => setState(() => _debugTouchTargets = val),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Micro-Icons with Invisible 48x48dp Padding',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Red boxes highlight the expanded 48x48dp hit area surrounding tiny 18px icons.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- TOOLBAR WITH MICRO ICONS ---
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Micro-Actions:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                ErgonomicTouchTarget(
                                  showDebugTargetBox: _debugTouchTargets,
                                  onTap: () => _showTapToast('Favorite Icon'),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                ),
                                ErgonomicTouchTarget(
                                  showDebugTargetBox: _debugTouchTargets,
                                  onTap: () => _showTapToast('Share Icon'),
                                  child: const Icon(
                                    Icons.share,
                                    size: 18,
                                    color: Colors.blue,
                                  ),
                                ),
                                ErgonomicTouchTarget(
                                  showDebugTargetBox: _debugTouchTargets,
                                  onTap: () => _showTapToast('Info Icon'),
                                  child: const Icon(
                                    Icons.info_outline,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Separated Choice Rows',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // CHOICE ROW 1: EMAIL OPT-IN
                    InkWell(
                      onTap: () => setState(() => _optInEmail = !_optInEmail),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            ErgonomicTouchTarget(
                              showDebugTargetBox: _debugTouchTargets,
                              onTap: () =>
                                  setState(() => _optInEmail = !_optInEmail),
                              child: Checkbox(
                                value: _optInEmail,
                                onChanged: (val) =>
                                    setState(() => _optInEmail = val ?? false),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Receive transaction notifications via Email',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // REQUIREMENT: Explicit horizontal/vertical margin rules between choice rows
                    const SizedBox(height: 12),

                    // CHOICE ROW 2: SMS OPT-IN
                    InkWell(
                      onTap: () => setState(() => _optInSms = !_optInSms),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            ErgonomicTouchTarget(
                              showDebugTargetBox: _debugTouchTargets,
                              onTap: () =>
                                  setState(() => _optInSms = !_optInSms),
                              child: Checkbox(
                                value: _optInSms,
                                onChanged: (val) =>
                                    setState(() => _optInSms = val ?? false),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Receive security alerts via SMS text',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- REQUIREMENT: LOWER-SCREEN THUMB REACH ZONE (FULL-WIDTH ACTION BUTTON) ---
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    // Full-width layout across mobile viewport
                    width: double.infinity,
                    // Hardcoded 48dp minimum height
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _showTapToast('Primary Checkout Action'),
                      child: const Text(
                        'Save & Continue to Payment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}
