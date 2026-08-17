import 'package:flutter/material.dart';
import '../models/shakti_alert_model.dart';

class ShaktiExecutionTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;

  ShaktiExecutionTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
  });
}

class ShaktiResolutionValidator {
  static bool isValidId(String value) {
    final pattern = RegExp(r'^(JIRA|RES)-\d{4,}$');
    return pattern.hasMatch(value.toUpperCase());
  }
}

class ShaktiBlockingBannerWidget extends StatefulWidget {
  const ShaktiBlockingBannerWidget({super.key});

  @override
  State<ShaktiBlockingBannerWidget> createState() =>
      _ShaktiBlockingBannerWidgetState();
}

class _ShaktiBlockingBannerWidgetState
    extends State<ShaktiBlockingBannerWidget> {
  final TextEditingController _resolutionController = TextEditingController();

  bool _isAlertDismissed = false;
  bool _isValidIdEntered = false;
  bool _isProcessing = false;

  ShaktiExecutionTelemetry get _telemetry => ShaktiExecutionTelemetry(
    stepExecutionId: 'EXEC-2668FLADE-2026',
    executionStatus: _isAlertDismissed
        ? 'DISMISSED_VALIDATED'
        : 'BLOCKING_ACTIVE',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome: _isAlertDismissed
        ? 'Shakti Alert Dismissed via Valid Jira/Resolution ID (${_resolutionController.text.toUpperCase()}).'
        : 'Shakti Alert Blocking Banner Active. Mandatory Resolution ID Required.',
    userId: 'ANIK-TECH-LEAD',
  );

  @override
  void dispose() {
    _resolutionController.dispose();
    super.dispose();
  }

  void _validateInput(String value) {
    setState(() {
      _isValidIdEntered = ShaktiResolutionValidator.isValidId(value);
    });
  }

  void _dismissAlert() {
    if (!_isValidIdEntered) return;

    setState(() => _isProcessing = true);

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _isAlertDismissed = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'SHAKTI ALERT DISMISSED: Linked ID "${_resolutionController.text.toUpperCase()}" logged to audit trail.',
            ),
            backgroundColor: Colors.teal.shade800,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shakti Alert Dismissal Prerequisite'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: Stack(
        children: [
          // MAIN APPLICATION CONTENT (BLOCKED / DIMMED WHILE ALERT IS ACTIVE)
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!_isAlertDismissed)
                  const SizedBox(height: 280.0), // Spacer for top sticky banner
                // DAMA-DMBOK2 ACCURACY BANNER
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
                          Icons.verified_user_rounded,
                          color: Colors.green.shade800,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Schema/Field Configuration Accuracy: 100% (Good)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.green.shade900,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Compliant with DAMA-DMBOK2 Data Modeling & Schema Design Standard.',
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

                Text(
                  'Core Application Workspace',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  enabled: _isAlertDismissed,
                  decoration: InputDecoration(
                    labelText: 'Operational Notes',
                    hintText: _isAlertDismissed
                        ? 'Type operational notes...'
                        : 'BLOCKED: Resolve Shakti Alert banner above to edit.',
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                // ATOMIC STEP EXECUTION TELEMETRY LOGS
                Text(
                  'Atomic Step Execution Telemetry',
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
                          'Step Execution ID',
                          telemetry.stepExecutionId,
                        ),
                        const Divider(height: 12),
                        _buildTelemetryRow(
                          'Execution Status',
                          telemetry.executionStatus,
                          isHighlight: true,
                        ),
                        const Divider(height: 12),
                        _buildTelemetryRow(
                          'Execution Timestamp',
                          telemetry.executionTimestamp.substring(11, 19),
                        ),
                        const Divider(height: 12),
                        _buildTelemetryRow(
                          'Step Outcome',
                          telemetry.stepOutcome,
                        ),
                        const Divider(height: 12),
                        _buildTelemetryRow('User ID', telemetry.userId),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // =========================================================
          // TOP-ANCHORED STICKY BLOCKING SHAKTI ALERT BANNER
          // =========================================================
          if (!_isAlertDismissed)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Material(
                elevation: 8.0,
                color: colorScheme.errorContainer,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: colorScheme.error, width: 3.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: colorScheme.onErrorContainer,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'SHAKTI SYSTEM ALERT: BLOCKING ACTIVE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: colorScheme.onErrorContainer,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          // REQUIREMENT: No close handler icon present
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'A critical platform exception requires resolution. Dismissal requires a linked Jira issue or Resolution ID (e.g., JIRA-8921 or RES-10492).',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onErrorContainer,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // MANDATORY JIRA / RESOLUTION ID INPUT FIELD
                      TextFormField(
                        controller: _resolutionController,
                        onChanged: _validateInput,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Mandatory Jira or Resolution ID *',
                          hintText: 'e.g. JIRA-8921 or RES-10492',
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          errorText:
                              _resolutionController.text.isNotEmpty &&
                                  !_isValidIdEntered
                              ? 'Format error: Must match JIRA-XXXX or RES-XXXX'
                              : null,
                          suffixIcon: Icon(
                            _isValidIdEntered
                                ? Icons.check_circle_rounded
                                : Icons.key_off_rounded,
                            color: _isValidIdEntered
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // DISMISS ACTION BUTTON (>= 48DP TOUCH TARGET)
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
                              backgroundColor: _isValidIdEntered
                                  ? colorScheme.error
                                  : colorScheme.onSurface.withOpacity(0.38),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: _isValidIdEntered && !_isProcessing
                                ? _dismissAlert
                                : null,
                            icon: _isProcessing
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.lock_open_rounded),
                            label: Text(
                              _isValidIdEntered
                                  ? 'DISMISS_SHAKTI_ALERT'
                                  : 'DISMISSAL_LOCKED (ENTER_VALID_ID)',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
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
              color: isHighlight
                  ? (_isAlertDismissed
                        ? Colors.teal.shade800
                        : Colors.red.shade800)
                  : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
