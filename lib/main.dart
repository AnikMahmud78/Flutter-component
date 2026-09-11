import 'package:flutter/material.dart';
import 'widgets/telemetry_health_sheet_4703BTPM019A06.dart';

void main() {
  runApp(const TelemetryHealthSheet4703BTPM019A06App());
}

class TelemetryHealthSheet4703BTPM019A06App extends StatelessWidget {
  const TelemetryHealthSheet4703BTPM019A06App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Telemetry Health Sheet App',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const TelemetryHealthSheet4703BTPM019A06(),
  );
}
