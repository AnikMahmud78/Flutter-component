import 'package:flutter/material.dart';
import 'models/mto_item.dart';
import 'widgets/split_screen_mto.dart';

void main() => runApp(const MtoApp());

class MtoApp extends StatelessWidget {
  const MtoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleItems = [
      const MtoItem(orderId: 'MTO-101', sku: 'SKU-A99', status: 'Pending', queueDetails: 'Material delay in section 4.'),
      const MtoItem(orderId: 'MTO-102', sku: 'SKU-B12', status: 'Flagged', queueDetails: 'Assembly dimension tolerance error.'),
    ];

    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan)),
      home: Scaffold(
        appBar: AppBar(title: const Text('MTO Operational Interface')),
        body: SplitScreenMtoWidget(items: sampleItems),
      ),
    );
  }
}
