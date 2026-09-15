import 'package:flutter/material.dart';
import 'widgets/nullable_fallback_renderer_widget_4538FEBFL021A06.dart';

void main() {
  runApp(const NullableFallbackApp4538FEBFL021A06());
}

class NullableFallbackApp4538FEBFL021A06 extends StatelessWidget {
  const NullableFallbackApp4538FEBFL021A06({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nullable Field Fallback App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const NullableFallbackRendererWidget4538FEBFL021A06(),
    );
  }
}
