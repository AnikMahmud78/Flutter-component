// lib/widgets/mcp_server_card.dart
import 'package:flutter/material.dart';

class McpServerCard extends StatelessWidget {
  const McpServerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MCP Server File Inspector', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12.0),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('marketing_mcp.py'),
          subtitle: const Text('Protocol: Model Context Protocol (Anthropic SDK v1.2)'),
          trailing: Icon(Icons.check_circle, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 16.0),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48.0)),
            onPressed: () {},
            icon: const Icon(Icons.terminal),
            label: const Text('VERIFY MCP SERVER SYNTAX'),
          ),
        ),
      ],
    );
  }
}
