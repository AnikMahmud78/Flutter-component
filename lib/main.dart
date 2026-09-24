import 'package:flutter/material.dart';
import 'models/availability_badge_model.dart';
import 'widgets/availability_badge_card.dart';

void main() {
  runApp(const AvailabilityBadgeApp());
}

class AvailabilityBadgeApp extends StatelessWidget {
  const AvailabilityBadgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Availability Badge Monitor',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      home: const AvailabilityBadgeScreen(),
    );
  }
}

class AvailabilityBadgeScreen extends StatefulWidget {
  const AvailabilityBadgeScreen({Key? key}) : super(key: key);

  @override
  State<AvailabilityBadgeScreen> createState() => _AvailabilityBadgeScreenState();
}

class _AvailabilityBadgeScreenState extends State<AvailabilityBadgeScreen> {
  AvailabilityBadgeModel _model = const AvailabilityBadgeModel(
    statusText: 'Available Today',
    isAvailable: true,
    accuracy: 0.999,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('M3 Availability Badge')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AvailabilityBadgeCard(
              model: _model,
              onToggleStatus: () {
                setState(() {
                  _model = AvailabilityBadgeModel(
                    statusText: _model.isAvailable ? 'Unavailable' : 'Available Today',
                    isAvailable: !_model.isAvailable,
                    accuracy: 0.999,
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
