import 'package:flutter/material.dart';
import 'widgets/print_preview_canvas_widget.dart';

void main() {
  runApp(const PrintPreviewApp());
}

class PrintPreviewApp extends StatelessWidget {
  const PrintPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Print Stylesheet Compiler',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const PrintPreviewCanvasWidget(),
    );
  }
}
