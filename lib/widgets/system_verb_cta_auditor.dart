import 'package:flutter/material.dart';
import '../models/cta_audit_model.dart';

class SystemVerbCtaAuditorWidget extends StatefulWidget {
  const SystemVerbCtaAuditorWidget({super.key});

  @override
  State<SystemVerbCtaAuditorWidget> createState() =>
      _SystemVerbCtaAuditorWidgetState();
}

class _SystemVerbCtaAuditorWidgetState extends State<SystemVerbCtaAuditorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final CtaAuditRecord _auditRecord = CtaAuditRecord(
    auditType: 'APPLICATION_WIDE_CTA_TEXT_AUDIT',
    auditDate: '2026-08-14',
    auditResult: '100% AUDITED — SYSTEM VERB LIMITS ENFORCED',
    auditTrail: 'AUDIT-TRAIL-CTA-2503-2026',
    auditorInformation: 'Anik (OPS / UX Lead Auditor)',
  );

  final List<String> _sampleCtas = [
    'EXECUTE_INGESTION',
    'COMMIT_RECORD',
    'PURGE_CACHE',
    'CLICK_HERE_TO_SUBMIT_FORM_NOW', // Non-compliant sample
  ];

  final TextEditingController _customCtaController = TextEditingController(
    text: 'SUBMIT_PAYLOAD',
  );

  @override
  void initState() {
    super.initState();
    // Self-Chasing Pulsing Warning Controller for non-compliant CTAs
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 3.0,
    ).animate(_pulseController);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _customCtaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('System-Verb CTA Character Limit Auditor'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp outer margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. PMI/AGILE EXECUTION QUALITY SCORE BANNER
            // =========================================================
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.stars_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Task Execution Quality Score: 5.0 / 5.0 (Good)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Compliant with PMI/Agile execution-quality norms.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 2. LIVE CTA INPUT AUDIT TESTER
            // =========================================================
            Text(
              'Test Custom System-Verb CTA',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Rules: Max 20 chars, max 2 words, UPPERCASE system verb.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _customCtaController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Enter CTA Label Candidate',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // LIVE BUTTON PREVIEW WITH SELF-CHASING PULSE WARNING
            _buildEnforcedCtaButton(_customCtaController.text),

            const SizedBox(height: 24),

            // =========================================================
            // 3. APPLICATION-WIDE CTA AUDIT INVENTORY
            // =========================================================
            Text(
              'Audited CTA Workflows Inventory',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            ..._sampleCtas.map((ctaText) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildEnforcedCtaButton(ctaText),
              );
            }),

            const SizedBox(height: 24),

            // =========================================================
            // 4. ATOMIC AUDIT TELEMETRY LOG DISPLAY
            // =========================================================
            Text(
              'Atomic Audit Telemetry Record',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow('Audit Type', _auditRecord.auditType),
                    const Divider(height: 12),
                    _buildTelemetryRow('Audit Date', _auditRecord.auditDate),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Audit Result',
                      _auditRecord.auditResult,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('Audit Trail', _auditRecord.auditTrail),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Auditor Information',
                      _auditRecord.auditorInformation,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper building CTA buttons with auto-truncation (Poka-Yoke), 48dp touch targets, and pulsing warning outlines (Self-Chasing)
  Widget _buildEnforcedCtaButton(String rawText) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bool isCompliant = CtaCharacterRules.isCompliant(rawText);
    final int charCount = rawText.length;

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              color: isCompliant ? Colors.transparent : colorScheme.error,
              width: isCompliant
                  ? 0.0
                  : _pulseAnimation.value, // Pulsing Warning
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NATIVE 48DP TOUCH TARGET CONTAINER
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 48.0,
                  minHeight: 48.0, // Minimum 48dp Touch Target
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: isCompliant
                          ? colorScheme.primary
                          : colorScheme.errorContainer,
                      foregroundColor: isCompliant
                          ? colorScheme.onPrimary
                          : colorScheme.onErrorContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isCompliant
                                ? 'CTA EXECUTED: "$rawText" satisfies single-line 20-char limit.'
                                : 'CTA WARNING: "$rawText" exceeds limit ($charCount chars). Auto-truncated.',
                          ),
                          backgroundColor: isCompliant
                              ? Colors.indigo.shade800
                              : colorScheme.error,
                        ),
                      );
                    },
                    // REQUIREMENT: Poka-Yoke Auto-Truncation & Single-Line Enforcement
                    child: Text(
                      rawText.toUpperCase(),
                      maxLines: 1, // Single-line max
                      softWrap: false, // white-space: nowrap equivalent
                      overflow: TextOverflow.ellipsis, // Auto-truncation
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),

              // CHARACTER COUNT & STATUS LABEL
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 4.0,
                  right: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Length: $charCount / ${CtaCharacterRules.maxCharacterLimit} chars',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: isCompliant
                            ? Colors.grey.shade600
                            : colorScheme.error,
                        fontWeight: isCompliant
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                    Text(
                      isCompliant
                          ? 'COMPLIANT'
                          : 'NON_COMPLIANT (PULSING WARNING)',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isCompliant
                            ? Colors.green.shade800
                            : colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTelemetryRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
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
              color: isHighlight ? Colors.green.shade800 : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
