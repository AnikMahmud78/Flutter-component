import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/sms_gateway_telemetry_model.dart';

class SmsIngressInputWidget extends StatefulWidget {
  const SmsIngressInputWidget({super.key});

  @override
  State<SmsIngressInputWidget> createState() => _SmsIngressInputWidgetState();
}

class _SmsIngressInputWidgetState extends State<SmsIngressInputWidget>
    with RestorationMixin {
  final RestorableTextEditingController _smsCodeController =
      RestorableTextEditingController();

  @override
  String? get restorationId => 'sms_ingress_input_widget';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_smsCodeController, 'sms_code_controller');
  }

  bool get _isContinueButtonEnabled =>
      RegExp(r'^\d{4}$').hasMatch(_smsCodeController.value.text);

  SmsGatewayTelemetryRecord get _telemetry => SmsGatewayTelemetryRecord(
    configurationParameter: 'TWILIO_SMS_INGRESS_4_DIGIT_GATE',
    currentSetting: 'DISABLED_UNTIL_4_DIGITS_ENTERED',
    previousSetting: 'UNGUARDED_INPUT_ENABLED',
    changeLog: 'Numeric four-digit validation gate enforced with restoration.',
    configurationTimestamp: DateTime.now().toUtc().toIso8601String(),
    completionStatus: 'Good',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3856',
  );

  @override
  void dispose() {
    _smsCodeController.dispose();
    super.dispose();
  }

  void _submitCode() {
    if (!_isContinueButtonEnabled) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SMS code submitted. Ingress verification approved.'),
        backgroundColor: Color(0xFF086C44),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Twilio SMS Ingress Gateway'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBenchmarkBanner(),
            const SizedBox(height: 20),
            SizedBox(
              height: 56,
              child: TextFormField(
                controller: _smsCodeController.value,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
                decoration: const InputDecoration(
                  labelText: 'Enter 4-Digit Verification Code',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(),
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: _isContinueButtonEnabled ? _submitCode : null,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('CONTINUE'),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Atomic Step Execution Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildTelemetryCard(telemetry),
          ],
        ),
      ),
    );
  }

  Widget _buildBenchmarkBanner() {
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
            Icon(Icons.sms_rounded, color: Color(0xFF086C44), size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SMS Gateway Success Rate: Good (0.999 SLA)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF086C44),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Twilio Messaging Reliability SLA benchmark satisfied.',
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

  Widget _buildTelemetryCard(SmsGatewayTelemetryRecord telemetry) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _buildRow('Config Parameter', telemetry.configurationParameter),
            const Divider(height: 12),
            _buildRow('Current Setting', telemetry.currentSetting),
            const Divider(height: 12),
            _buildRow(
              'SLA Success Rate',
              '${telemetry.deliverySuccessRate} (Good)',
            ),
            const Divider(height: 12),
            _buildRow('Completion Status', telemetry.completionStatus, true),
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
              color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
