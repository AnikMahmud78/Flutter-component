// lib/main.dart
import 'package:flutter/material.dart';
import 'models/openapi_contract_model.dart';
import 'widgets/ingress_contract_card.dart';
import 'widgets/openapi_validity_banner.dart';

void main() {
  runApp(const ContractApp());
}

class ContractApp extends StatelessWidget {
  const ContractApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ingress Contract Generator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ContractScreen(),
    );
  }
}

class ContractScreen extends StatelessWidget {
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const contracts = [
      OpenApiContractModel(providerName: 'AppsFlyer Webhook', endpointPath: '/v1/ingress/appsflyer', isSchemaValid: true, completionStatus: 'Complete', actionEventTimestamp: '2026-09-16T12:47:00.000Z', userSessionId: 'SESS-GEN-0392'),
      OpenApiContractModel(providerName: 'Branch.io Event Stream', endpointPath: '/v1/ingress/branch', isSchemaValid: true, completionStatus: 'Complete', actionEventTimestamp: '2026-09-16T12:47:00.000Z', userSessionId: 'SESS-GEN-0392'),
      OpenApiContractModel(providerName: 'Meta CAPI Queue', endpointPath: '/v1/ingress/meta_capi', isSchemaValid: true, completionStatus: 'Complete', actionEventTimestamp: '2026-09-16T12:47:00.000Z', userSessionId: 'SESS-GEN-0392'),
      OpenApiContractModel(providerName: 'Google Ads Webhook', endpointPath: '/v1/ingress/google_ads', isSchemaValid: true, completionStatus: 'Complete', actionEventTimestamp: '2026-09-16T12:47:00.000Z', userSessionId: 'SESS-GEN-0392'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('OpenAPI 3.0 Contracts (GEN-00392)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            OpenApiValidityBanner(status: 'Complete'),
            IngressContractCard(contracts: contracts),
          ],
        ),
      ),
    );
  }
}
