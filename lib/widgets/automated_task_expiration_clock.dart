import 'dart:async';
import 'package:flutter/material.dart';
import '../models/proxy_loader_model.dart';

class AutomatedTaskExpirationClock extends StatefulWidget {
  const AutomatedTaskExpirationClock({super.key});

  @override
  State<AutomatedTaskExpirationClock> createState() =>
      _AutomatedTaskExpirationClockState();
}

class _AutomatedTaskExpirationClockState
    extends State<AutomatedTaskExpirationClock> {
  static const int _totalDurationSeconds =
      300; // Fixed 5-Minute Expiration Timer
  int _secondsRemaining = _totalDurationSeconds;

  Timer? _countdownTimer;
  bool _isLocked = false;
  bool _isAutoSubmitted = false;

  final ProxyLoaderModel _proxyModel = ProxyLoaderModel();
  final TextEditingController _inputController = TextEditingController(
    text: 'OPERATOR-TASK-PAYLOAD-IN-PROGRESS',
  );

  @override
  void initState() {
    super.initState();
    _startCountdownTimer();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _inputController.dispose();
    super.dispose();
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 1) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        _handleTaskExpiration();
      }
    });
  }

  // REQUIREMENT: Freeze inputs instantly and submit empty string to trigger escalation loops
  void _handleTaskExpiration() {
    setState(() {
      _secondsRemaining = 0;
      _isLocked = true;
      _isAutoSubmitted = true;
      _proxyModel.isTaskExpired = true;
      _proxyModel.isEscalationDispatched = true;
    });

    // Auto-dispatches empty string payload "" to backend escalation
    _submitPayloadToBackend(emptyStringPayload: "");
  }

  void _submitPayloadToBackend({required String emptyStringPayload}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isLocked
              ? 'TASK EXPIRED: Interface locked. Empty payload ("$emptyStringPayload") dispatched to escalation loop.'
              : 'Manual Payload Submitted Successfully.',
        ),
        backgroundColor: _isLocked
            ? Colors.red.shade900
            : Colors.green.shade800,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _resetDemoTimer() {
    setState(() {
      _secondsRemaining = _totalDurationSeconds;
      _isLocked = false;
      _isAutoSubmitted = false;
      _proxyModel.isTaskExpired = false;
      _proxyModel.isEscalationDispatched = false;
    });
    _startCountdownTimer();
  }

  String _formatTime(int totalSeconds) {
    int mins = totalSeconds ~/ 60;
    int secs = totalSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // REQUIREMENT: Alert-red color shift when 1 minute (<= 60s) remains
    final bool isCriticalState = _secondsRemaining <= 60;
    final Color timerColor = _isLocked
        ? colorScheme.error
        : (isCriticalState ? colorScheme.error : colorScheme.primary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Micro-Task Expiration Lock'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================================================
                // 1. FLOATING / ANCHORED COUNTDOWN INDICATOR WIDGET
                // =========================================================
                Card.filled(
                  color: isCriticalState
                      ? colorScheme.errorContainer
                      : colorScheme.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: timerColor, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value:
                                    _secondsRemaining / _totalDurationSeconds,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  timerColor,
                                ),
                                backgroundColor: timerColor.withAlpha(40),
                                strokeWidth: 4.0,
                              ),
                              Icon(
                                _isLocked ? Icons.lock : Icons.timer,
                                color: timerColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isLocked
                                    ? 'TASK EXPIRED & LOCKED'
                                    : (isCriticalState
                                          ? 'EXPIRATION WARNING (< 1 MIN)'
                                          : 'TASK EXPIRATION TIMER'),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isCriticalState
                                      ? colorScheme.onErrorContainer
                                      : colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _formatTime(_secondsRemaining),
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  color: isCriticalState
                                      ? colorScheme.onErrorContainer
                                      : colorScheme.onSurface,
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
                // 2. PROTECTED INPUT FRAME (FROZEN WHEN TIMER = 0)
                // =========================================================
                Text(
                  'Micro-Task Data Entry Field',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: _inputController,
                  enabled:
                      !_isLocked, // REQUIREMENT: Freeze input when timer hits zero
                  decoration: InputDecoration(
                    labelText: 'Task Payload Inspection',
                    border: const OutlineInputBorder(),
                    filled: _isLocked,
                    fillColor: Colors.grey.shade200,
                    suffixIcon: Icon(
                      _isLocked ? Icons.lock_outline : Icons.edit_note,
                      color: _isLocked ? colorScheme.error : Colors.green,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 48, // Minimum 48dp Touch Target
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                    ),
                    onPressed: _isLocked
                        ? null
                        : () => _submitPayloadToBackend(
                            emptyStringPayload: _inputController.text,
                          ),
                    icon: const Icon(Icons.send),
                    label: Text(
                      _isLocked
                          ? 'INPUT FROZEN (Task Expired)'
                          : 'Submit Micro-Task Entry',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // =========================================================
                // 3. UI COMPONENT PROXY LOADER METADATA
                // =========================================================
                Text(
                  'Proxy Loader Package Details',
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
                        _buildMetaRow('Library Name', _proxyModel.libraryName),
                        const Divider(height: 12),
                        _buildMetaRow(
                          'Library Version',
                          _proxyModel.libraryVersion,
                        ),
                        const Divider(height: 12),
                        _buildMetaRow(
                          'Component Count',
                          _proxyModel.componentCount.toString(),
                        ),
                        const Divider(height: 12),
                        _buildMetaRow(
                          'Installation Status',
                          _proxyModel.installationStatus,
                        ),
                        const Divider(height: 12),
                        _buildMetaRow(
                          'Dependencies',
                          _proxyModel.dependencyList.join(', '),
                        ),
                        const Divider(height: 12),
                        _buildMetaRow(
                          'Location Path',
                          _proxyModel.libraryLocationPath,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // DEMO RESET CONTROL BUTTON
                if (_isLocked)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: _resetDemoTimer,
                      icon: const Icon(Icons.restart_alt_rounded),
                      label: const Text('Reset 5-Minute Timer (Demo)'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
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
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
