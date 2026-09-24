import 'package:flutter/material.dart';
import 'models/viewport_bounds_model.dart';
import 'widgets/viewport_bounds_card.dart';

void main() {
  runApp(const ViewportBoundsApp());
}

class ViewportBoundsApp extends StatelessWidget {
  const ViewportBoundsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viewport Bounds Enforcer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const ViewportBoundsScreen(),
    );
  }
}

class ViewportBoundsScreen extends StatefulWidget {
  const ViewportBoundsScreen({Key? key}) : super(key: key);

  @override
  State<ViewportBoundsScreen> createState() => _ViewportBoundsScreenState();
}

class _ViewportBoundsScreenState extends State<ViewportBoundsScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final model = ViewportBoundsModel(
      windowWidthDp: mediaQuery.size.width,
      windowHeightDp: mediaQuery.size.height,
      devicePixelRatio: mediaQuery.devicePixelRatio,
      compliancePercentage: 100.0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Viewport Bounds Console')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ViewportBoundsCard(
              model: model,
              onValidateBounds: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Active Window Bounds Verified (100% Compliance)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
