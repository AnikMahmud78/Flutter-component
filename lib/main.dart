import 'package:flutter/material.dart';
import 'models/vector_migration_model.dart';
import 'services/asset_audit_engine.dart';
import 'widgets/asset_comparison_card.dart';
import 'widgets/payload_savings_banner.dart';

void main() {
  runApp(const HABOTVectorApp());
}

class HABOTVectorApp extends StatelessWidget {
  const HABOTVectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10214GEN-01983 Vector Migration',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00639B)),
      ),
      home: const VectorScreen(),
    );
  }
}

class VectorScreen extends StatefulWidget {
  const VectorScreen({super.key});

  @override
  State<VectorScreen> createState() => _VectorScreenState();
}

class _VectorScreenState extends State<VectorScreen> {
  late VectorMigrationModel _model;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    setState(() {
      _model = AssetAuditEngine.calculatePayloadSavings(
        taskId: '10214GEN-01983',
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vector Asset Migration Manager')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PayloadSavingsBanner(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            AssetComparisonCard(model: _model, onAudit: _load),
          ],
        ),
      ),
    );
  }
}
