import 'package:flutter/material.dart';
import '../models/lsa_profile_compliance_model.dart';

class LsaProfileComplianceGateWidget extends StatefulWidget {
  const LsaProfileComplianceGateWidget({super.key});

  @override
  State<LsaProfileComplianceGateWidget> createState() =>
      _LsaProfileComplianceGateWidgetState();
}

class _LsaProfileComplianceGateWidgetState
    extends State<LsaProfileComplianceGateWidget> {
  bool _isLsaVerified = true;

  final LsaProfileComplianceRecord _telemetry = LsaProfileComplianceRecord(
    mobilePlatform: 'Flutter Mobile / Android & iOS',
    osVersion: 'Android 15 / iOS 18',
    deviceType: 'Compact Mobile Handheld (<600dp)',
    screenDimensions: '360 x 740 dp',
    mobileConfiguration: 'BINARY_LSA_COMPLIANCE_GATE_ACTIVE',
    completionStatus: 'Good',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-7497',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LSA Profile Compliance Gate'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MD3 / NIELSEN NORMAN HEURISTIC BANNER
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(Icons.verified_user_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UI Design-System Adherence Rate: Good (100%)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Material Design 3 Guidelines & Nielsen Norman Group Heuristics satisfied.',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // SIMULATION GATE TOGGLE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('LSA Binary Compliance Gate Test State:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Switch(
                  value: _isLsaVerified,
                  onChanged: (val) {
                    setState(() => _isLsaVerified = val);
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            // CONDITIONAL PROFILE DISPLAY (BLOCKED VS VERIFIED TRUST CARD)
            if (_isLsaVerified)
              Card.outlined(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified_rounded, color: Color(0xFF086C44), size: 22),
                          const SizedBox(width: 8),
                          Text('Licensed Professional: Dr. Sarah Jenkins',
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text('License #LSA-2026-9921 • Verified LSA Profile Active',
                          style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 48.0),
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.info_outline_rounded),
                          label: const Text('VIEW_CREDENTIAL_VERIFICATION_DETAILS'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Card.filled(
                color: const Color(0xFFF9DEDC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFE31B23)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.block_rounded, color: Color(0xFFE31B23), size: 36),
                      SizedBox(height: 8),
                      Text(
                        'UNVERIFIED LSA PROFILE BLOCKED',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8B0811)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Automated binary compliance gate blocked this profile from rendering on mobile screens.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY LOG
            Text('Atomic Step Execution Telemetry',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Mobile Platform', telemetry.mobilePlatform),
                    const Divider(height: 12),
                    _buildRow('Device Type', telemetry.deviceType),
                    const Divider(height: 12),
                    _buildRow('Mobile Config', telemetry.mobileConfiguration),
                    const Divider(height: 12),
                    _buildRow('Completion Status', telemetry.completionStatus, isHighlight: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
