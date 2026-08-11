import 'package:flutter/material.dart';
import 'models/sla_breach_item.dart';
import 'widgets/sla_breach_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '15-Minute Chat SLA Dashboard',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const SlaDashboardScreen(),
    );
  }
}

class SlaDashboardScreen extends StatefulWidget {
  const SlaDashboardScreen({super.key});

  @override
  State<SlaDashboardScreen> createState() => _SlaDashboardScreenState();
}

class _SlaDashboardScreenState extends State<SlaDashboardScreen> {
  late Stopwatch _stopwatch;
  double _loadTimeSeconds = 0.0;
  bool _isLoading = true;

  final List<SlaBreachItem> _sampleBreaches = [
    SlaBreachItem(
      id: 'SLA-101',
      customerName: 'Sarah Jenkins',
      channel: 'Mobile Chat',
      missedMessage:
          'I requested a refund 20 minutes ago and have not received a confirmation.',
      waitTimeMinutes: 22,
      timestamp: '2026-08-11 08:52:10 UTC',
    ),
    SlaBreachItem(
      id: 'SLA-102',
      customerName: 'Ahmad Al-Mansoor',
      channel: 'In-App Support',
      missedMessage:
          'Payment failed at step 2, can someone verify my account status?',
      waitTimeMinutes: 18,
      timestamp: '2026-08-11 08:56:45 UTC',
    ),
    SlaBreachItem(
      id: 'SLA-103',
      customerName: 'Elena Rostova',
      channel: 'Web Checkout',
      missedMessage: 'Where do I enter the promo code on mobile checkout?',
      waitTimeMinutes: 16,
      timestamp: '2026-08-11 08:58:30 UTC',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();

    // Simulate W3C Optimized Dashboard Fetch (<1.5s Optimal Target)
    Future.delayed(const Duration(milliseconds: 320), () {
      _stopwatch.stop();
      if (mounted) {
        setState(() {
          _loadTimeSeconds = _stopwatch.elapsedMilliseconds / 1000.0;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Management Dashboard'),
        backgroundColor: Colors.red.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- PERFORMANCE METRIC CARD ---
            Card(
              color: Colors.blueGrey.shade900,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'W3C Dashboard Load Time:',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    Text(
                      '${_loadTimeSeconds.toStringAsFixed(3)}s (Good)',
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Real-Time Communication SLA Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              )
            else
              SlaBreachWidget(initialBreaches: _sampleBreaches),
          ],
        ),
      ),
    );
  }
}
