import 'package:flutter/material.dart';
import 'models/add_on_selector_model.dart';
import 'widgets/add_on_selector_card.dart';

void main() {
  runApp(const AddOnSelectorApp());
}

class AddOnSelectorApp extends StatelessWidget {
  const AddOnSelectorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkout Add-On Package',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const AddOnSelectorScreen(),
    );
  }
}

class AddOnSelectorScreen extends StatefulWidget {
  const AddOnSelectorScreen({Key? key}) : super(key: key);

  @override
  State<AddOnSelectorScreen> createState() => _AddOnSelectorScreenState();
}

class _AddOnSelectorScreenState extends State<AddOnSelectorScreen> {
  AddOnSelectorModel _model = const AddOnSelectorModel(
    addOnId: 'ADDON-9752-01',
    addOnTitle: 'Priority Service Protection & Insurance',
    price: 4.99,
    isSelected: false,
    attachRate: 0.28,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Add-On Module')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AddOnSelectorCard(
              model: _model,
              onToggle: (selected) {
                setState(() {
                  _model = AddOnSelectorModel(
                    addOnId: _model.addOnId,
                    addOnTitle: _model.addOnTitle,
                    price: _model.price,
                    isSelected: selected,
                    attachRate: _model.attachRate,
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
