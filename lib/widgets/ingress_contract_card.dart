// lib/widgets/ingress_contract_card.dart
import 'package:flutter/material.dart';
import '../models/openapi_contract_model.dart';

class IngressContractCard extends StatelessWidget {
  final List<OpenApiContractModel> contracts;

  const IngressContractCard({super.key, required this.contracts});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registered Ingress Providers', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                final item = contracts[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.api, color: theme.colorScheme.primary),
                  title: Text(item.providerName),
                  subtitle: Text(item.endpointPath, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                  trailing: Chip(
                    label: Text(item.isSchemaValid ? 'VALID' : 'INVALID'),
                    backgroundColor: theme.colorScheme.primaryContainer,
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
                onPressed: () {},
                icon: const Icon(Icons.verified),
                label: const Text('VALIDATE OPENAPI 3.0 SCHEMAS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
