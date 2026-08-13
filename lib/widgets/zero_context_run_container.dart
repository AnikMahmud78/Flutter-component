import 'package:flutter/material.dart';
import '../models/admin_repo_telemetry.dart';

class ZeroContextRunContainer extends StatefulWidget {
  const ZeroContextRunContainer({super.key});

  @override
  State<ZeroContextRunContainer> createState() =>
      _ZeroContextRunContainerState();
}

class _ZeroContextRunContainerState extends State<ZeroContextRunContainer> {
  final AdminRepoTelemetry _repoTelemetry = AdminRepoTelemetry();
  final TextEditingController _singleInputController = TextEditingController();

  bool _isSignedLinkValid = true;
  bool _isProcessing = false;

  // Single-purpose task payload initialized via temporary signed link
  late EncapsulatedTaskPayload _activeTaskPayload;

  @override
  void initState() {
    super.initState();
    _activeTaskPayload = EncapsulatedTaskPayload(
      taskId: 'TASK-2041-ZERO-CONTEXT',
      temporarySignedLink:
          'https://signed-link.internal.net/task/2041?exp=1786638000&sig=a8f491c',
      systemInstructionLine:
          'SYSTEM_CMD: INGEST_AND_VERIFY_TAX_IDENTIFICATION_NUMBER',
      evidenceCardTitle: 'SUPPLIER RECEIPT INVOICE #99812',
      evidenceCardValue: 'TAX-IDENTIFIER-EXTRACTED: TAX-99812-X',
      targetFieldKey: 'tax_identifier_input',
    );
  }

  @override
  void dispose() {
    _singleInputController.dispose();
    super.dispose();
  }

  void _executeTaskTransition() {
    if (_singleInputController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'SYSTEM_ALERT: Input field required before triggering transition.',
          ),
          backgroundColor: Colors.red.shade800,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _isProcessing = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'SYSTEM_SUCCESS: Single-purpose input verified & transitional payload dispatched via signed link.',
            ),
            backgroundColor: Colors.indigo.shade800,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Operation Workspace'),
        backgroundColor: colorScheme.surfaceContainerHigh,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Chip(
              avatar: const Icon(
                Icons.shield_outlined,
                size: 16,
                color: Colors.green,
              ),
              label: const Text(
                'Zero-Context Active',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.green.shade50,
              side: BorderSide(color: Colors.green.shade300),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp outer margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. REPOSITORY ASSET DISCOVERY COMPLETENESS BANNER
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
                      Icons.inventory_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discovery Completeness: 100% (Complete)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Admin panel source repository inventory fully confirmed.',
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
            // 2. TEMPORARY SIGNED LINK & SYSTEM INSTRUCTION LINE
            // =========================================================
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.link_rounded,
                        color: Colors.cyanAccent,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'TEMPORARY SIGNED PARAMETER LINK',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _isSignedLinkValid ? 'VALID' : 'EXPIRED',
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _activeTaskPayload.temporarySignedLink,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(color: Colors.white24, height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.terminal_rounded,
                        color: Colors.amberAccent,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _activeTaskPayload.systemInstructionLine,
                          style: const TextStyle(
                            color: Colors.amberAccent,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 3. SPLIT-SCREEN / STACKED VIEW: EVIDENCE CARD & ENTRY FORM
            // =========================================================
            Text(
              'Encapsulated Work Viewport',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // EVIDENCE CARD (Matching Source Document)
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _activeTaskPayload.evidenceCardTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        _activeTaskPayload.evidenceCardValue,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // SINGLE-PURPOSE INPUT BOX WITH BOLD VISUAL ACCENT FRAMING
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verify & Input Tax Identification Number *',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    // REQUIREMENT: Bold visual accent border framing active item field
                    border: Border.all(color: colorScheme.primary, width: 2.0),
                  ),
                  child: TextFormField(
                    controller: _singleInputController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. TAX-99812-X',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 4. OVERSIZED MAIN SELECTOR BUTTON (>=48x48 DP TOUCH TARGET)
            // =========================================================
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 48.0,
                minHeight: 48.0, // Minimum 48dp Touch Target Spec
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _isProcessing ? null : _executeTaskTransition,
                  icon: _isProcessing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.check_circle_outline_rounded),
                  label: const Text(
                    'EXECUTE_SINGLE_TASK_TRANSITION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 5. ADMIN PANEL REPOSITORY TELEMETRY SUMMARY
            // =========================================================
            Text(
              'Admin Repository Discovery Telemetry',
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
                    _buildTelemetryRow(
                      'Repository URL',
                      _repoTelemetry.repositoryUrl,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Repository Branch',
                      _repoTelemetry.repositoryBranch,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Access Rights',
                      _repoTelemetry.accessRights,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Commit History',
                      _repoTelemetry.commitHistory,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Repository Version',
                      _repoTelemetry.repositoryVersion,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Clone Status',
                      _repoTelemetry.cloneStatus,
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

  Widget _buildTelemetryRow(String label, String value) {
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
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
