import 'package:flutter/material.dart';
import 'models/modal_focus_model.dart';
import 'widgets/modal_focus_card.dart';

void main() {
  runApp(const ModalFocusApp());
}

class ModalFocusApp extends StatelessWidget {
  const ModalFocusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modal Focus Bounding',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const ModalFocusScreen(),
    );
  }
}

class ModalFocusScreen extends StatefulWidget {
  const ModalFocusScreen({Key? key}) : super(key: key);

  @override
  State<ModalFocusScreen> createState() => _ModalFocusScreenState();
}

class _ModalFocusScreenState extends State<ModalFocusScreen> {
  ModalFocusModel _model = const ModalFocusModel(isModalOpen: false, prRejectionRate: 99.5);

  void _showBoundedModal() {
    showDialog(
      context: context,
      builder: (context) => FocusScope(
        autofocus: true,
        child: AlertDialog(
          title: const Text('Bounded Modal'),
          content: const Text('Focus is trapped inside this modal dialog.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close Modal'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Focus Management Console')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ModalFocusCard(
              model: _model,
              onOpenModal: _showBoundedModal,
            ),
          ],
        ),
      ),
    );
  }
}
