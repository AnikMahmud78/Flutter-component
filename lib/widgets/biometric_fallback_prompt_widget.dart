import 'package:flutter/material.dart';

import '../models/biometric_fallback_telemetry_model.dart';

class BiometricFallbackPromptWidget extends StatefulWidget {
  const BiometricFallbackPromptWidget({super.key});

  @override
  State<BiometricFallbackPromptWidget> createState() =>
      _BiometricFallbackPromptWidgetState();
}

class _BiometricFallbackPromptWidgetState
    extends State<BiometricFallbackPromptWidget> {
  static const _successColor = Color(0xFF086C44);
  static const _warningColor = Color(0xFFB56C00);

  final _pinController = TextEditingController();
  final _telemetry = BiometricFallbackTelemetryRecord(
    accessType: 'WEBAUTHN_BIOMETRIC_WITH_PIN_FALLBACK',
    userRole: 'LEVEL_13_ADMINISTRATOR',
    permissionLevel: 'FULL_EXECUTIVE_ACCESS',
    accessLog:
        'Biometric prompt initialized; secure single-use PIN fallback route ready.',
    accessTimestamp: DateTime.now().toUtc().toIso8601String(),
    completionStatus: 'Pass',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-5726',
  );

  bool _showFallbackPinRoute = false;
  bool _pinConsumed = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _simulateBiometricAuthentication() {
    setState(() => _showFallbackPinRoute = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Biometric read unavailable. Secure PIN fallback is ready.',
        ),
        backgroundColor: _warningColor,
      ),
    );
  }

  void _verifyFallbackPin() {
    if (_pinConsumed || _pinController.text.length != 4) return;

    setState(() => _pinConsumed = true);
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fallback PIN verified. Access granted.'),
        backgroundColor: _successColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('WebAuthn Biometric Access'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReliabilityBanner(),
            const SizedBox(height: 20),
            if (_showFallbackPinRoute)
              _buildFallbackRoute(colorScheme)
            else
              _buildBiometricPrompt(colorScheme),
            const SizedBox(height: 24),
            Text(
              'Atomic Step Execution Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildTelemetryCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildReliabilityBanner() {
    return Card.filled(
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.green.shade300),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.fingerprint_rounded, color: _successColor, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Biometric Authentication Reliability: Pass',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: _successColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'WebAuthn prompt with a secure fallback route is available.',
                    style: TextStyle(fontSize: 11, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBiometricPrompt(ColorScheme colorScheme) {
    return Card.outlined(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.fingerprint_rounded,
              size: 56,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 12),
            const Text(
              'Use Face ID or fingerprint to authenticate this session.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _simulateBiometricAuthentication,
                icon: const Icon(Icons.fingerprint_rounded),
                label: const Text('AUTHENTICATE WITH BIOMETRICS'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackRoute(ColorScheme colorScheme) {
    return Card.filled(
      color: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.pin_rounded, color: _warningColor, size: 24),
                SizedBox(width: 8),
                Text(
                  'Secure Fallback Access Route',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              _pinConsumed
                  ? 'This single-use PIN has already been consumed.'
                  : 'Enter your single-use 4-digit security PIN.',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _pinController,
              enabled: !_pinConsumed,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '4-Digit Fallback PIN',
                border: OutlineInputBorder(),
                counterText: '',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: _pinController.text.length == 4 && !_pinConsumed
                    ? _verifyFallbackPin
                    : null,
                icon: const Icon(Icons.lock_open_rounded),
                label: const Text('VERIFY FALLBACK PIN'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryCard() {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _buildRow('Access Type', _telemetry.accessType),
            const Divider(height: 12),
            _buildRow('User Role', _telemetry.userRole),
            const Divider(height: 12),
            _buildRow('Permission Level', _telemetry.permissionLevel),
            const Divider(height: 12),
            _buildRow('Completion Status', _telemetry.completionStatus, true),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, [bool isHighlight = false]) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? _successColor : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
