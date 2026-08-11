import 'package:flutter/material.dart';
import '../models/fail_closed_mapping.dart';

class FailClosedEngineScreen extends StatefulWidget {
  const FailClosedEngineScreen({super.key});

  @override
  State<FailClosedEngineScreen> createState() => _FailClosedEngineScreenState();
}

class _FailClosedEngineScreenState extends State<FailClosedEngineScreen> {
  // REQUIREMENT: M3 Semantic Red (#B3261E) Color Token
  static const Color m3SemanticRed = Color(0xFFB3261E);
  static const Color m3OnErrorContainer = Color(0xFF601410);

  // Simulated Perimeter Security Constraint States
  bool _isApiTokenValid = true;
  bool _isPayloadWithinCeiling =
      false; // Constraint Failed -> Triggers Fail-Closed
  bool _isOriginVerified = true;

  final TextEditingController _payloadController = TextEditingController(
    text: "150 KB (Exceeds 100 KB Limits)",
  );

  List<FailClosedMapping> get _mappingRules => [
    FailClosedMapping(
      sourceElementId: 'SRC-PERIMETER-01',
      targetElementId: 'TGT-GATEWAY-INGRESS',
      mappingRule: 'API Gateway Content-Length < 100KB Ceiling',
      isConstraintMet: _isPayloadWithinCeiling,
      mappingStatus: _isPayloadWithinCeiling
          ? 'VERIFIED'
          : 'FAIL_CLOSED_ACTIVE',
    ),
    FailClosedMapping(
      sourceElementId: 'SRC-AUTH-TOKEN-02',
      targetElementId: 'TGT-IAM-AUTHORIZER',
      mappingRule: 'Bearer Token Active & Unexpired',
      isConstraintMet: _isApiTokenValid,
      mappingStatus: _isApiTokenValid ? 'VERIFIED' : 'FAIL_CLOSED_ACTIVE',
    ),
    FailClosedMapping(
      sourceElementId: 'SRC-ORIGIN-03',
      targetElementId: 'TGT-FIREWALL-RULE',
      mappingRule: 'Origin Domain Matches Trustlist',
      isConstraintMet: _isOriginVerified,
      mappingStatus: _isOriginVerified ? 'VERIFIED' : 'FAIL_CLOSED_ACTIVE',
    ),
  ];

  bool get _isSystemHalted =>
      !_isApiTokenValid || !_isPayloadWithinCeiling || !_isOriginVerified;

  @override
  void dispose() {
    _payloadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fail-Closed Logic Engine'),
        backgroundColor: _isSystemHalted
            ? m3SemanticRed.withAlpha(25)
            : Colors.green.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- EXPLICIT WARNING BANNER (M3 SEMANTIC RED #B3261E) ---
            if (_isSystemHalted) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: m3SemanticRed,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: m3SemanticRed.withAlpha(60),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.block_rounded, color: Colors.white, size: 32),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SYSTEM HALTED: FAIL-CLOSED DEFAULT ACTIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Security constraints violated. Systemic visual blockage enforced. Navigation & write access revoked per NIST SP 800-53 AC-3.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // SECURITY CONSTRAINT SIMULATOR CONTROLS
            const Text(
              'Security Constraint Engine Controls',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SwitchListTile(
                      activeColor: Colors.green,
                      title: const Text('Payload Size Within Ceiling (<100KB)'),
                      subtitle: Text(
                        _isPayloadWithinCeiling ? 'Pass' : 'Failed (150KB)',
                      ),
                      value: _isPayloadWithinCeiling,
                      onChanged: (val) =>
                          setState(() => _isPayloadWithinCeiling = val),
                    ),
                    SwitchListTile(
                      activeColor: Colors.green,
                      title: const Text('API Token Validity'),
                      value: _isApiTokenValid,
                      onChanged: (val) =>
                          setState(() => _isApiTokenValid = val),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- SYSTEMIC VISUAL BLOCKAGE ACROSS FIELDS ---
            const Text(
              'Protected System Inputs',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),

            TextFormField(
              controller: _payloadController,
              enabled: !_isSystemHalted, // Disabled on System Halt
              decoration: InputDecoration(
                labelText: 'Payload Ingestion Parameter',
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isSystemHalted
                        ? m3SemanticRed
                        : Colors.grey.shade400,
                    width: _isSystemHalted ? 2.0 : 1.0,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: m3SemanticRed, width: 2.0),
                ),
                filled: _isSystemHalted,
                fillColor: m3SemanticRed.withAlpha(15),
                suffixIcon: Icon(
                  _isSystemHalted ? Icons.error : Icons.check_circle,
                  color: _isSystemHalted ? m3SemanticRed : Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- MAPPING RULES AUDIT SUMMARY ---
            const Text(
              'Atomic Mapping Rules Evaluation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            ..._mappingRules.map((mapping) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: mapping.isConstraintMet
                        ? Colors.green.shade300
                        : m3SemanticRed,
                    width: mapping.isConstraintMet ? 1.0 : 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  dense: true,
                  title: Text(
                    '${mapping.sourceElementId} → ${mapping.targetElementId}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  subtitle: Text(
                    mapping.mappingRule,
                    style: const TextStyle(fontSize: 11),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: mapping.isConstraintMet
                          ? Colors.green.shade50
                          : m3SemanticRed.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      mapping.mappingStatus,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: mapping.isConstraintMet
                            ? Colors.green.shade900
                            : m3SemanticRed,
                      ),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // --- LOCKED NAVIGATION / ACTION CHOICE FRAME ---
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                // REQUIREMENT: Systemic visual blockage / locked navigation frame
                onPressed: _isSystemHalted
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Transaction Payload Processed!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: m3SemanticRed.withAlpha(40),
                  disabledForegroundColor: m3OnErrorContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: _isSystemHalted
                          ? m3SemanticRed
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: Text(
                  _isSystemHalted
                      ? 'LOCKED (Fail-Closed Default Active)'
                      : 'Execute Compliant Ingestion',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
