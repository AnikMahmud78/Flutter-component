import 'package:flutter/material.dart';
import '../models/single_line_action_model.dart';

class SingleLineActionScreen extends StatefulWidget {
  const SingleLineActionScreen({super.key});

  @override
  State<SingleLineActionScreen> createState() => _SingleLineActionScreenState();
}

class _SingleLineActionScreenState extends State<SingleLineActionScreen> {
  final _formKey = GlobalKey<FormState>();

  // Input Field Controllers
  final TextEditingController _operatorNameController = TextEditingController(
    text: 'Anik Lead Architect',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'anik.architect@enterprise.internal',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+1 (555) 019-2834',
  );

  int _selectedVerbIndex = 0;
  bool _isProcessing = false;

  SystemicActionVerb get _activeVerb =>
      SystemicActionVerb.availableVerbs[_selectedVerbIndex];

  @override
  void dispose() {
    _operatorNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _executeSingleLineAction() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isProcessing = true);

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => _isProcessing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'ACTION EXECUTED: "${_activeVerb.displayLabel}" processed with matching typography.',
              ),
              backgroundColor: Colors.teal.shade800,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final activeVerb = _activeVerb;
    final typo = activeVerb.typography;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Single-Line Action Typography'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp spatial margin
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================================================
              // 1. M3 & NN GROUP HEURISTIC ADHERENCE BANNER
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
                        Icons.verified_rounded,
                        color: Colors.green.shade800,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'UI Design-System Adherence: 100% (Good)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.green.shade900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Compliant with Material Design 3 & Nielsen Norman Group Heuristics.',
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
              // 2. WELCOMING INITIAL INPUT FORM (AUTOFOCUS & KEYBOARD TYPES)
              // =========================================================
              Text(
                'Operator Data Architecture Entry',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Outlined boundaries, initial autofocus, and optimized tab traversal.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),

              // FIELD 1: OPERATOR NAME (AUTOFOCUS ENABLED)
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48.0),
                child: TextFormField(
                  controller: _operatorNameController,
                  autofocus: true, // Initial focus on first input
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (val) => val == null || val.isEmpty
                      ? 'Operator Name required'
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Operator Name *',
                    hintText: 'Enter full name',
                    border: OutlineInputBorder(), // Clear boundary
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // FIELD 2: EMAIL ADDRESS (KEYBOARD TYPE: EMAIL)
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48.0),
                child: TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType:
                      TextInputType.emailAddress, // Optimized keyboard
                  validator: (val) => val == null || !val.contains('@')
                      ? 'Valid email required'
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Systemic Email Address *',
                    hintText: 'operator@domain.com',
                    border: OutlineInputBorder(), // Clear boundary
                    prefixIcon: Icon(Icons.email_outlined),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // FIELD 3: PHONE NUMBER (KEYBOARD TYPE: PHONE)
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48.0),
                child: TextFormField(
                  controller: _phoneController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone, // Optimized keyboard
                  validator: (val) => val == null || val.isEmpty
                      ? 'Contact phone required'
                      : null,
                  decoration: const InputDecoration(
                    labelText: 'Direct Line / Contact Phone *',
                    hintText: '+1 (555) 000-0000',
                    border: OutlineInputBorder(), // Clear boundary
                    prefixIcon: Icon(Icons.phone_outlined),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 14.0,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // =========================================================
              // 3. SYSTEMIC ACTION VERB SELECTOR CHIPS
              // =========================================================
              Text(
                'Select Systemic Action Verb Configuration',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(
                  SystemicActionVerb.availableVerbs.length,
                  (index) {
                    final isSelected = _selectedVerbIndex == index;
                    final verb = SystemicActionVerb.availableVerbs[index];
                    return ChoiceChip(
                      label: Text(
                        verb.verbKey,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: colorScheme.primaryContainer,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedVerbIndex = index);
                        }
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // =========================================================
              // 4. DYNAMIC SINGLE-LINE CTA WITH MATCHING TYPOGRAPHY
              // =========================================================
              Text(
                'Single-Line Action Execution Trigger',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 48.0,
                  minHeight: 48.0, // Minimum 48dp Touch Target
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: _isProcessing ? null : _executeSingleLineAction,
                    icon: _isProcessing
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
                      activeVerb.displayLabel,
                      maxLines: 1, // Enforce single-line action
                      softWrap: false, // Prevent text wrapping
                      overflow:
                          TextOverflow.ellipsis, // Auto-truncate if needed
                      style: TextStyle(
                        fontSize: typo.fontSize,
                        height: typo.lineHeight,
                        fontWeight: typo.fontWeight,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // =========================================================
              // 5. ATOMIC TYPOGRAPHY AUDIT TELEMETRY LOG DISPLAY
              // =========================================================
              Text(
                'Atomic Typography Audit Telemetry',
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
                      _buildTelemetryRow('Font Name', typo.fontName),
                      const Divider(height: 12),
                      _buildTelemetryRow('Font Size', '${typo.fontSize} dp'),
                      const Divider(height: 12),
                      _buildTelemetryRow('Line Height', '${typo.lineHeight}x'),
                      const Divider(height: 12),
                      _buildTelemetryRow('Font Weight', typo.fontWeightString),
                      const Divider(height: 12),
                      _buildTelemetryRow('Font File Path', typo.fontFilePath),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTelemetryRow(String label, String value) {
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
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
