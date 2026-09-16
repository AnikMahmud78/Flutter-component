// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/mcp_server_card.dart';
import 'widgets/anthropic_mcp_banner.dart';

void main() {
  runApp(const McpServerApp());
}

class McpServerApp extends StatelessWidget {
  const McpServerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCP Server Integration',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const McpScreen(),
    );
  }
}

class McpScreen extends StatelessWidget {
  const McpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MCP Server (GEN-00579)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AnthropicMcpBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: McpServerCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
