import 'package:flutter/material.dart';
import 'models/service_detail_model.dart';
import 'widgets/service_detail_chassis.dart';

void main() {
  runApp(const ServiceDetailApp());
}

class ServiceDetailApp extends StatelessWidget {
  const ServiceDetailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Service Detail Chassis',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const ServiceDetailScreen(),
    );
  }
}

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const detailModel = ServiceDetailModel(
      serviceId: 'SRV-9697-MASTER',
      title: 'Premium Home Cleaning & Organization',
      providerName: 'Elite Home Solutions',
      hourlyRate: 45.0,
      rating: 4.9,
      iaTaskSuccessRate: 0.95,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Service Details')),
      body: ServiceDetailChassis(
        model: detailModel,
        onBookNow: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Service Booking Initiated (IA Task Success: 95%)')),
          );
        },
      ),
    );
  }
}
