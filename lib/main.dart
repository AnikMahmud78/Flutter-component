import 'package:flutter/material.dart';
import 'models/fail_closed_banner_tokens.dart';
import 'widgets/fail_closed_blocking_banner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fail-Closed Blocking Banner',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const FailClosedScreen(),
    );
  }
}

class FailClosedScreen extends StatefulWidget {
  const FailClosedScreen({super.key});

  @override
  State<FailClosedScreen> createState() => _FailClosedScreenState();
}

class _FailClosedScreenState extends State<FailClosedScreen> {
  bool _isFailClosedActive = true;
  final FailClosedBannerTokens _tokens = FailClosedBannerTokens();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Monitoring Workstation'),
        backgroundColor: Colors.red.shade50,
      ),
      body: Column(
        children: [
          // =========================================================
          // 1. MD3 UN-DISMISSIBLE FAIL-CLOSED BLOCKING BANNER AT TOP
          // =========================================================
          if (_isFailClosedActive) const FailClosedBlockingBanner(),

          // Main Workspace View
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0), // 16px Grid Margins
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CONTROL SIMULATOR CARD
                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fail-Closed Banner Engine',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'Toggle security constraint state to test banner display.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isFailClosedActive,
                            activeColor: Colors.red.shade800,
                            onChanged: (val) {
                              setState(() {
                                _isFailClosedActive = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ATOMIC DATA FIELDS SUMMARY
                  Text(
                    'Atomic Layout Parameters',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Card.filled(
                    color: Colors.blueGrey.shade900,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          _buildMetaRow('Layout Type', _tokens.layoutType),
                          const Divider(color: Colors.white24),
                          _buildMetaRow(
                            'Grid Dimensions',
                            _tokens.layoutGridDimensions,
                          ),
                          const Divider(color: Colors.white24),
                          _buildMetaRow('Spacing Rules', _tokens.spacingRules),
                          const Divider(color: Colors.white24),
                          _buildMetaRow(
                            'Alignment Settings',
                            _tokens.alignmentSettings,
                          ),
                          const Divider(color: Colors.white24),
                          _buildMetaRow(
                            'Validation Status',
                            _tokens.layoutValidationStatus,
                          ),
                          const Divider(color: Colors.white24),
                          _buildMetaRow(
                            'UI System Adherence',
                            '100% (${_tokens.completionStatus})',
                            isHighlight: true,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // WORKSPACE INPUT FORM (Disabled when Fail-Closed Active)
                  Text(
                    'Protected Transaction Controls',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextFormField(
                    enabled: !_isFailClosedActive,
                    initialValue: 'TX-PAYLOAD-1579-SECURE',
                    decoration: InputDecoration(
                      labelText: 'Ingestion Data Payload',
                      border: const OutlineInputBorder(),
                      filled: _isFailClosedActive,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 48.0, // Minimum 48dp Touch Target
                    child: ElevatedButton(
                      onPressed: _isFailClosedActive
                          ? null
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Payload Executed Successfully!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        _isFailClosedActive
                            ? 'LOCKED (Fail-Closed Banner Active)'
                            : 'Execute Ingestion',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? Colors.greenAccent : Colors.cyanAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
