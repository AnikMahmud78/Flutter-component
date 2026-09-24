import 'package:flutter/material.dart';
import 'widgets/m3_bottom_sheet_modal.dart';

void main() => runApp(const ModalApp());

class ModalApp extends StatelessWidget {
  const ModalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      home: Scaffold(
        appBar: AppBar(title: const Text('M3 Bottom Sheet Demo')),
        body: Center(
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () => M3BottomSheetModal.show(context),
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open M3 Bottom Sheet'),
            ),
          ),
        ),
      ),
    );
  }
}
