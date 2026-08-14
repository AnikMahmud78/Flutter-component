import 'package:flutter/material.dart';
import '../models/fab_system_verb_model.dart';

class SystemVerbFabScreen extends StatefulWidget {
  const SystemVerbFabScreen({super.key});

  @override
  State<SystemVerbFabScreen> createState() => _SystemVerbFabScreenState();
}

class _SystemVerbFabScreenState extends State<SystemVerbFabScreen> {
  final TextEditingController _inputPayloadController = TextEditingController(
    text: 'INGESTION_PAYLOAD_SCHEMA_VERIFIED_V2',
  );

  int _selectedDefinitionIdx = 0;
  bool _isExecuting = false;

  FabDefinitionRecord get _currentDefinition =>
      FabSystemVerbDictionary.locatedDefinitions[_selectedDefinitionIdx];

  String get _activeSystemVerb {
    switch (_selectedDefinitionIdx) {
      case 0:
        return FabSystemVerbDictionary.executeIngestion;
      case 1:
        return FabSystemVerbDictionary.commitRecord;
      case 2:
        return FabSystemVerbDictionary.authenticateSession;
      case 3:
        return FabSystemVerbDictionary.purgeCache;
      default:
        return FabSystemVerbDictionary.executeIngestion;
    }
  }

  @override
  void dispose() {
    _inputPayloadController.dispose();
    super.dispose();
  }

  void _executeFabSystemVerb() {
    setState(() => _isExecuting = true);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _isExecuting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'ACTION EXECUTED: Objective System-Verb "$_activeSystemVerb" triggered successfully.',
            ),
            backgroundColor: Colors.indigo.shade800,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentDef = _currentDefinition;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAB System-Verb Inventory'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        // REQUIREMENT: Single-action view per scroll depth (16dp outer padding)
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 90.0, // Space reserved for Floating Action Button
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. TOUCH TARGET & ACCESSIBILITY COMPLIANCE BANNER
            // =========================================================
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.touch_app_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Touch Target Compliance: Good (48px / WCAG AA)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Google Material Design 3 Guidelines & WCAG 2.1 AA (≥4.5:1 contrast).',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 2. LOCATED FAB VERB SELECTOR CHIPS
            // =========================================================
            Text(
              'Select Located FAB Definition String',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                FabSystemVerbDictionary.locatedDefinitions.length,
                (index) {
                  final isSelected = _selectedDefinitionIdx == index;
                  final record =
                      FabSystemVerbDictionary.locatedDefinitions[index];
                  return ChoiceChip(
                    label: Text(
                      record.definitionId,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurface,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: colorScheme.primaryContainer,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedDefinitionIdx = index;
                        });
                      }
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 3. FULL-WIDTH INPUT CONTROL WITH 48X48 DP MINIMUM TAP ZONE
            // =========================================================
            Text(
              'Operational Payload Parameter',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            // REQUIREMENT: Full width inputs requiring minimum 48x48dp tap zones (padding: 8px)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 48.0,
                  minHeight: 48.0, // Minimum 48dp Tap Zone
                ),
                child: SizedBox(
                  width: double.infinity, // Full Width
                  child: TextFormField(
                    controller: _inputPayloadController,
                    decoration: const InputDecoration(
                      labelText: 'Payload Data Stream',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 4. ATOMIC DEFINITION TELEMETRY DISPLAY
            // =========================================================
            Text(
              'Atomic Definition Telemetry Record',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow(
                      'Definition ID',
                      currentDef.definitionId,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Definition Name',
                      currentDef.definitionName,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Definition Type',
                      currentDef.definitionType,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Definition Parameters',
                      currentDef.definitionParameters,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Validation Status',
                      currentDef.validationStatus,
                      isHighlight: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // =========================================================
      // 5. OBJECTIVE SYSTEM-VERB FLOATING ACTION BUTTON (FAB)
      // =========================================================
      // REQUIREMENT: Minimum 48x48dp tap zone, high contrast (>=4.5:1), M3 Extended FAB
      floatingActionButton: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 48.0,
          minHeight: 48.0, // WCAG AA 48dp Minimum Touch Target
        ),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.indigo.shade900, // High Contrast Fill
          foregroundColor: Colors.white, // High Contrast Text (Contrast > 7:1)
          elevation: 4.0,
          onPressed: _isExecuting ? null : _executeFabSystemVerb,
          icon: _isExecuting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.flash_on_rounded),
          label: Text(
            _activeSystemVerb, // Strict Machine-Action System Verb
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              fontSize: 13,
            ),
          ),
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
