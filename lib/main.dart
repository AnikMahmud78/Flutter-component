import 'dart:async';
import 'package:flutter/material.dart';
import 'models/access_policy_model.dart';
import 'widgets/access_policy_card.dart';

void main() {
  runApp(const AccessPolicyApp());
}

class AccessPolicyApp extends StatelessWidget {
  const AccessPolicyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Context-Aware Access Console',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PolicyDashboardScreen(),
    );
  }
}

class PolicyDashboardScreen extends StatefulWidget {
  const PolicyDashboardScreen({Key? key}) : super(key: key);

  @override
  State<PolicyDashboardScreen> createState() => _PolicyDashboardScreenState();
}

class _PolicyDashboardScreenState extends State<PolicyDashboardScreen> {
  late AccessPolicyModel _currentPolicy;
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _evaluatePolicy();
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _evaluatePolicy();
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  void _evaluatePolicy() {
    setState(() {
      _currentPolicy = AccessPolicyModel(
        tokenId: 'tok_corp_mob_99182',
        clientIp: '198.51.100.45',
        isCorporateEgress: true,
        complianceRate: 100.0,
        status: 'Pass',
        timestamp: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security & Access Governance'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 840;
          return RefreshIndicator(
            onRefresh: () async => _evaluatePolicy(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 1200 : 600,
                  ),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AccessPolicyCard(
                                policyData: _currentPolicy,
                                onRefresh: _evaluatePolicy,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'BigQuery Audit Pipeline',
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text('Partitioning: event_date\nClustering: trace_id'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : AccessPolicyCard(
                          policyData: _currentPolicy,
                          onRefresh: _evaluatePolicy,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
