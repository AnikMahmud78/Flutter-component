import 'package:flutter/material.dart';
import 'models/m3_error_handler_model.dart';
import 'widgets/m3_error_handler_card.dart';

void main() {
  runApp(const M3ErrorHandlerApp());
}

class M3ErrorHandlerApp extends StatelessWidget {
  const M3ErrorHandlerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M3 Error Handler',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const M3ErrorHandlerScreen(),
    );
  }
}

class M3ErrorHandlerScreen extends StatefulWidget {
  const M3ErrorHandlerScreen({Key? key}) : super(key: key);

  @override
  State<M3ErrorHandlerScreen> createState() => _M3ErrorHandlerScreenState();
}

class _M3ErrorHandlerScreenState extends State<M3ErrorHandlerScreen> {
  M3ErrorHandlerModel _model = const M3ErrorHandlerModel(errorMessage: null, completionRate: 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MD3 Error Guidelines')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            M3ErrorHandlerCard(
              model: _model,
              onTriggerError: () {
                setState(() {
                  _model = M3ErrorHandlerModel(
                    errorMessage: _model.hasError ? null : 'Invalid account identifier format',
                    completionRate: 100.0,
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
