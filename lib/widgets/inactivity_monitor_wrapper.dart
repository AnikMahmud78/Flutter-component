import 'dart:async';
import 'package:flutter/material.dart';

class InactivityMonitorWrapper extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;
  final Duration inactivityTimeout;
  final Duration warningDuration;

  const InactivityMonitorWrapper({
    super.key,
    required this.child,
    required this.navigatorKey,
    this.inactivityTimeout = const Duration(seconds: 10),
    this.warningDuration = const Duration(seconds: 5),
  });

  @override
  State<InactivityMonitorWrapper> createState() =>
      _InactivityMonitorWrapperState();
}

class _InactivityMonitorWrapperState extends State<InactivityMonitorWrapper> {
  Timer? _inactivityTimer;
  Timer? _countdownTimer;
  int _secondsRemaining = 5;
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    _resetInactivityTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _resetInactivityTimer() {
    _inactivityTimer?.cancel();
    _countdownTimer?.cancel();

    // Use global navigatorKey state to dismiss dialog safely
    if (_isDialogShowing) {
      final navState = widget.navigatorKey.currentState;
      if (navState != null && navState.canPop()) {
        navState.pop();
      }
      _isDialogShowing = false;
    }

    final warningDelay = widget.inactivityTimeout - widget.warningDuration;
    _inactivityTimer = Timer(warningDelay, _showTimeoutWarningModal);
  }

  void _showTimeoutWarningModal() {
    final navContext = widget.navigatorKey.currentContext;
    if (navContext == null || !mounted || _isDialogShowing) return;

    setState(() {
      _isDialogShowing = true;
      _secondsRemaining = widget.warningDuration.inSeconds;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 1) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        _terminateSession();
      }
    });

    final theme = Theme.of(navContext);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: navContext,
      barrierDismissible: false,
      builder: (dialogContext) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            backgroundColor: colorScheme.errorContainer,
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorScheme.onErrorContainer,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Text(
                  'Session Inactivity Warning',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'No user interaction detected. Your session will automatically terminate in:',
                  style: TextStyle(
                    color: colorScheme.onErrorContainer,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '00:0${_secondsRemaining}s',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _resetInactivityTimer();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text(
                    'Extend Session',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _terminateSession() {
    final navState = widget.navigatorKey.currentState;
    if (_isDialogShowing && navState != null && navState.canPop()) {
      navState.pop();
      _isDialogShowing = false;
    }

    final navContext = widget.navigatorKey.currentContext;
    if (navContext != null) {
      ScaffoldMessenger.of(navContext).showSnackBar(
        const SnackBar(
          content: Text(
            'Session Terminated due to inactivity. Re-authentication required.',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _resetInactivityTimer(),
      onPointerMove: (_) => _resetInactivityTimer(),
      child: widget.child,
    );
  }
}
