import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/programmatic_engine_model.dart';
import '../registry/component_registry.dart';

class DynamicLayoutRendererScreen extends StatefulWidget {
  const DynamicLayoutRendererScreen({super.key});

  @override
  State<DynamicLayoutRendererScreen> createState() =>
      _DynamicLayoutRendererScreenState();
}

class _DynamicLayoutRendererScreenState
    extends State<DynamicLayoutRendererScreen> {
  // Simulated Backend JSON Layout Payload String
  final String _rawBackendJsonPayload = '''
  {
    "screenId": "SCREEN_2591_DYNAMIC_INGESTION",
    "title": "Programmatic Ingestion Viewport",
    "components": [
      {
        "type": "InfoBanner",
        "properties": {
          "title": "UI Design-System Adherence: 100% (Good)",
          "message": "Dynamic layout engine operational. Zero ad-hoc styling modifications present."
        }
      },
      {
        "type": "HeaderCard",
        "properties": {
          "title": "SUPPLIER_INGESTION_MASTER_RECORD",
          "subtitle": "Catalog Target: db_catalog_enterprise_prod • Schema v4.2.0",
          "codeTag": "SHA256:e3b0c44298fc1c149afbf4c8996fb9242"
        }
      },
      {
        "type": "FormInputField",
        "properties": {
          "label": "Verified Tax Identification Code",
          "hint": "e.g., TAX-99821-X"
        }
      },
      {
        "type": "ActionVerbButton",
        "properties": {
          "actionVerb": "EXECUTE_INGESTION"
        }
      }
    ]
  }
  ''';

  late ProgrammaticEngineBuildTelemetry _telemetry;

  @override
  void initState() {
    super.initState();
    _telemetry = ProgrammaticEngineBuildTelemetry(
      buildStatus: 'SUCCESS',
      buildTimestamp: DateTime.now().toUtc().toIso8601String(),
      buildArtifactsPath: 'lib/registry/component_registry.dart',
      buildLogs:
          'BUILD_PASS: 4 JSON component types mapped to Flutter code artifacts.',
      buildDuration: '142 ms',
    );
  }

  List<ComponentSchemaNode> _parseSchemaNodes() {
    final Map<String, dynamic> parsedJson = jsonDecode(_rawBackendJsonPayload);
    final List<dynamic> rawComponents =
        parsedJson['components'] as List<dynamic>;
    return rawComponents
        .map((c) => ComponentSchemaNode.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final schemaNodes = _parseSchemaNodes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Programmatic Layout Engine'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp outer margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DYNAMICALLY RENDERED WIDGET TREE FROM COMPONENT REGISTRY DICTIONARY
            ...schemaNodes.map((node) {
              return ComponentRegistry.buildComponent(
                node.type,
                node.properties,
                context,
              );
            }),

            const SizedBox(height: 16.0),

            // ATOMIC BUILD TELEMETRY LOG DISPLAY
            Text(
              'Atomic Build Telemetry Logs',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow(
                      'Build Status',
                      _telemetry.buildStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Build Timestamp',
                      _telemetry.buildTimestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Build Artifacts Path',
                      _telemetry.buildArtifactsPath,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Build Duration',
                      _telemetry.buildDuration,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('Build Logs', _telemetry.buildLogs),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? Colors.green.shade800 : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
