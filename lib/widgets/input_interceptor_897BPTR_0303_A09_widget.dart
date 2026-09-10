import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExecutionTrackingInterceptor897BPTR0303A09Formatter
    extends TextInputFormatter {
  final ValueChanged<String> onInputEvent;

  ExecutionTrackingInterceptor897BPTR0303A09Formatter({
    required this.onInputEvent,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    onInputEvent(newValue.text);
    return newValue;
  }
}

class InputInterceptor897BPTR0303A09Widget extends StatefulWidget {
  const InputInterceptor897BPTR0303A09Widget({super.key});

  @override
  State<InputInterceptor897BPTR0303A09Widget> createState() =>
      _InputInterceptor897BPTR0303A09WidgetState();
}

class _InputInterceptor897BPTR0303A09WidgetState
    extends State<InputInterceptor897BPTR0303A09Widget> {
  String _lastEvent = 'NO_EVENTS_CAPTURED';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          inputFormatters: [
            ExecutionTrackingInterceptor897BPTR0303A09Formatter(
              onInputEvent: (value) => setState(() => _lastEvent = value),
            ),
          ],
          decoration: const InputDecoration(
            labelText: 'Monitored input',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        Text('Last intercepted event: $_lastEvent'),
      ],
    );
  }
}
