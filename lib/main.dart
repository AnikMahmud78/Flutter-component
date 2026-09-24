import 'package:flutter/material.dart';
import 'models/catalog_bi_metrics_model.dart';
import 'widgets/catalog_bi_dashboard_card.dart';

void main() {
  runApp(const CatalogBiApp());
}

class CatalogBiApp extends StatelessWidget {
  const CatalogBiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Catalog BI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const CatalogBiScreen(),
    );
  }
}

class CatalogBiScreen extends StatefulWidget {
  const CatalogBiScreen({Key? key}) : super(key: key);

  @override
  State<CatalogBiScreen> createState() => _CatalogBiScreenState();
}

class _CatalogBiScreenState extends State<CatalogBiScreen> {
  late CatalogBiMetricsModel _metrics;

  @override
  void initState() {
    super.initState();
    _metrics = CatalogBiMetricsModel(
      dashboardId: 'CAT-BI-9708',
      bounceRatePercentage: 24.5,
      avgTabDwellTimeSeconds: 42.8,
      lastRefreshed: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catalog BI Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CatalogBiDashboardCard(
              model: _metrics,
              onRefresh: () {
                setState(() {
                  _metrics = CatalogBiMetricsModel(
                    dashboardId: 'CAT-BI-9708',
                    bounceRatePercentage: 22.1,
                    avgTabDwellTimeSeconds: 45.3,
                    lastRefreshed: DateTime.now(),
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Catalog BI Telemetry Synced with BigQuery')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
