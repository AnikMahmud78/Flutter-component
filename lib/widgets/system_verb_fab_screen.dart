import 'package:flutter/material.dart';
import '../models/system_verb_tokens.dart';

class SystemVerbFabScreen extends StatefulWidget {
  const SystemVerbFabScreen({super.key});

  @override
  State<SystemVerbFabScreen> createState() => _SystemVerbFabScreenState();
}

class _SystemVerbFabScreenState extends State<SystemVerbFabScreen> {
  final TextEditingController _endpointController = TextEditingController(
    text: SystemVerbTokens.hintTargetEndpoint,
  );
  final TextEditingController _notesController = TextEditingController();

  final SystemVerbLayoutMetadata _layoutMetadata = SystemVerbLayoutMetadata();
  String _activeFabVerbToken = SystemVerbTokens.fabExecuteIngestion;
  bool _isExecuting = false;

  @override
  void dispose() {
    _endpointController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _executeObjectiveSystemVerb() {
    setState(() => _isExecuting = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isExecuting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${SystemVerbTokens.statusIngestionSuccess} Verb: "$_activeFabVerbToken"',
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Objective System-Verb Triggers'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        // Single-action view per scroll depth
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 90.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ACCESSIBILITY & TOKEN COMPLIANCE HEADER CARD
            Card.filled(
              color: Colors.indigo.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.indigo.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.accessibility_new_rounded,
                      color: Colors.indigo.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SystemVerbTokens.statusTokenValidationPass,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.indigo.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Touch Target Compliance: 48x48dp (WCAG 2.1 AA Compliant)',
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

            Text(
              'Select Objective System-Verb Action',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // SYSTEM-VERB SELECTOR CHIPS (Tokenized text references)
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildVerbChip(SystemVerbTokens.fabExecuteIngestion),
                _buildVerbChip(SystemVerbTokens.fabSaveRecord),
                _buildVerbChip(SystemVerbTokens.fabRefreshTelemetry),
              ],
            ),

            const SizedBox(height: 24),

            // FULL-WIDTH INPUT FIELDS (Strict 48dp minimum tap zone constraint)
            _buildTokenizedInputField(
              labelToken: SystemVerbTokens.labelTargetEndpoint,
              hintToken: SystemVerbTokens.hintTargetEndpoint,
              controller: _endpointController,
            ),
            const SizedBox(height: 16),

            _buildTokenizedInputField(
              labelToken: SystemVerbTokens.labelOperatorNotes,
              hintToken: SystemVerbTokens.hintOperatorNotes,
              controller: _notesController,
              maxLines: 2,
            ),

            const SizedBox(height: 24),

            // BUTTON TRIGGER WITH TOKENIZED VERB & 48DP MINIMUM TOUCH TARGET
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 48.0,
                minHeight: 48.0, // Minimum 48dp tap zone
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _executeObjectiveSystemVerb,
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: Text(
                    SystemVerbTokens.btnSubmitPayload, // Reference string token
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC LAYOUT METADATA SUMMARY
            Text(
              'Atomic Layout Configuration',
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
                    _buildMetaRow('Layout Type', _layoutMetadata.layoutType),
                    const Divider(height: 12.0),
                    _buildMetaRow(
                      'Grid Dimensions',
                      _layoutMetadata.layoutGridDimensions,
                    ),
                    const Divider(height: 12.0),
                    _buildMetaRow(
                      'Spacing Rules',
                      _layoutMetadata.spacingRules,
                    ),
                    const Divider(height: 12.0),
                    _buildMetaRow(
                      'Alignment Settings',
                      _layoutMetadata.alignmentSettings,
                    ),
                    const Divider(height: 12.0),
                    _buildMetaRow(
                      'Layout Validation',
                      _layoutMetadata.layoutValidationStatus,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // OBJECTIVE SYSTEM-VERB FLOATING ACTION BUTTON (FAB)
      floatingActionButton: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 48.0,
          minHeight: 48.0, // WCAG AA 48dp Minimum Tap Zone
        ),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.indigo.shade800,
          foregroundColor: Colors.white,
          onPressed: _isExecuting ? null : _executeObjectiveSystemVerb,
          icon: _isExecuting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.play_arrow_rounded),
          label: Text(
            _activeFabVerbToken, // Reference string token
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerbChip(String verbToken) {
    final isSelected = _activeFabVerbToken == verbToken;
    return ChoiceChip(
      label: Text(
        verbToken,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.indigo.shade900 : Colors.black87,
        ),
      ),
      selected: isSelected,
      selectedColor: Colors.indigo.shade100,
      onSelected: (val) {
        if (val) setState(() => _activeFabVerbToken = verbToken);
      },
    );
  }

  Widget _buildTokenizedInputField({
    required String labelToken,
    required String hintToken,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelToken, // Token reference
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(height: 6),
        // Full width input requiring min 48x48dp tap zone
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintToken, // Token reference
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
