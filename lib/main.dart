import 'package:flutter/material.dart';
import 'models/z_index_overlay_model.dart';
import 'widgets/z_index_overlay_card.dart';

void main() {
  runApp(const ZIndexOverlayApp());
}

class ZIndexOverlayApp extends StatelessWidget {
  const ZIndexOverlayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Z-Index Overlay Barrier',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const ZIndexOverlayScreen(),
    );
  }
}

class ZIndexOverlayScreen extends StatefulWidget {
  const ZIndexOverlayScreen({Key? key}) : super(key: key);

  @override
  State<ZIndexOverlayScreen> createState() => _ZIndexOverlayScreenState();
}

class _ZIndexOverlayScreenState extends State<ZIndexOverlayScreen> {
  ZIndexOverlayModel _model = const ZIndexOverlayModel(isOverlayActive: false, complianceRate: 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Z-Index Touch Enforcer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ZIndexOverlayCard(
              model: _model,
              onToggleOverlay: () {
                setState(() {
                  _model = ZIndexOverlayModel(
                    isOverlayActive: !_model.isOverlayActive,
                    complianceRate: 100.0,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
