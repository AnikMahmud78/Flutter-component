import 'package:flutter/material.dart';
import 'widgets/m3_date_picker_field.dart';

void main() => runApp(const DatePickerApp());

class DatePickerApp extends StatelessWidget {
  const DatePickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)),
      home: Scaffold(
        appBar: AppBar(title: const Text('M3 DatePicker Integration')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: M3DatePickerField(
            labelText: 'Effective Audit Date',
            onDateSelected: (date) {},
          ),
        ),
      ),
    );
  }
}
