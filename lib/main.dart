import 'package:flutter/material.dart';
import 'models/geofence_feature_model.dart';
import 'services/geofence_engine.dart';
import 'widgets/geofence_status_card.dart';
import 'widgets/geofence_metric_banner.dart';

void main() {
  runApp(const HABOTGeofenceApp());
}

class HABOTGeofenceApp extends StatelessWidget {
  const HABOTGeofenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10247GEN-02016 Geofence Features',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF356A5D)),
      ),
      home: const GeofenceScreen(),
    );
  }
}

class GeofenceScreen extends StatefulWidget {
  const GeofenceScreen({super.key});

  @override
  State<GeofenceScreen> createState() => _GeofenceScreenState();
}

class _GeofenceScreenState extends State<GeofenceScreen> {
  late GeofenceFeatureModel _model;

  @override
  void initState() {
    super.initState();
    _ping();
  }

  void _ping() {
    setState(() {
      _model = GeofenceEngine.checkLocation(
        taskId: '10247GEN-02016',
        lat: 25.7439,
        lng: 89.2752,
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Geofence Auto-Unlock Engine')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GeofenceMetricBanner(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            GeofenceStatusCard(model: _model, onRefreshLocation: _ping),
          ],
        ),
      ),
    );
  }
}
