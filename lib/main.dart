import 'package:flutter/material.dart';
import 'models/field_subtext_model.dart';
import 'services/field_subtext_service.dart';
import 'widgets/action_field_widget.dart';
import 'widgets/subtext_status_banner.dart';

void main() {
  runApp(const HABOTSubtextApp());
}

class HABOTSubtextApp extends StatelessWidget {
  const HABOTSubtextApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10302GEN-02073 Field Subtext',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006A6A)),
      ),
      home: const SubtextScreen(),
    );
  }
}

class SubtextScreen extends StatefulWidget {
  const SubtextScreen({super.key});

  @override
  State<SubtextScreen> createState() => _SubtextScreenState();
}

class _SubtextScreenState extends State<SubtextScreen> {
  late FieldSubtextModel _model;

  @override
  void initState() {
    super.initState();
    _model = FieldSubtextService.getSubtextConfig(
      taskId: '10302GEN-02073',
      userId: 'USER-ANIK-8821',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Actionable Subtext Field Renderer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SubtextStatusBanner(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            ActionFieldWidget(model: _model),
          ],
        ),
      ),
    );
  }
}
