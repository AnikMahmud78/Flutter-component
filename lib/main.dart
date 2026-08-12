import 'package:flutter/material.dart';
import 'models/required_field_tokens.dart';
import 'widgets/required_form_field_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Required Field Indicator Engine',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const RequiredFieldDemoScreen(),
    );
  }
}

class RequiredFieldDemoScreen extends StatefulWidget {
  const RequiredFieldDemoScreen({super.key});

  @override
  State<RequiredFieldDemoScreen> createState() =>
      _RequiredFieldDemoScreenState();
}

class _RequiredFieldDemoScreenState extends State<RequiredFieldDemoScreen> {
  final _formKey = GlobalKey<FormState>();
  final RequiredFieldTokens _tokens = RequiredFieldTokens();

  final TextEditingController _vendorNameController = TextEditingController(
    text: 'Acme Global Logistics',
  );
  final TextEditingController _billDateController = TextEditingController();
  final TextEditingController _taxIdController = TextEditingController();

  @override
  void dispose() {
    _vendorNameController.dispose();
    _billDateController.dispose();
    _taxIdController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form Validation Passed! 100% Required Fields Valid.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Form Validation Failed: Fill all mandatory fields (*).',
          ),
          backgroundColor: RequiredFieldTokens.m3SemanticRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mandatory Input Indicator System'),
        backgroundColor: Colors.indigo.shade50,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // 16px Grid Margins
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DISCOVERY COVERAGE BANNER
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
                      Icons.check_circle_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discovery & Audit Coverage: 100% (Complete)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'All mandatory fields enforce M3 red asterisk (*) token rules.',
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
              'Supplier Ingestion Data Form',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Fields marked with a red asterisk (*) are strictly required.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // FORM CONTAINER
            Form(
              key: _formKey,
              child: Column(
                children: [
                  RequiredFormFieldBuilder(
                    label: 'Vendor Name',
                    hintText: 'Enter legal vendor name',
                    helperText: 'Mandatory for billing classification.',
                    isMandatory: true,
                    controller: _vendorNameController,
                  ),
                  RequiredFormFieldBuilder(
                    label: 'Bill Date',
                    hintText: 'YYYY-MM-DD',
                    helperText: 'Select or type invoice date.',
                    isMandatory: true,
                    controller: _billDateController,
                  ),
                  RequiredFormFieldBuilder(
                    label: 'Tax Identification Number (Tax ID)',
                    hintText: 'TAX-0000000-X',
                    helperText: 'Required for tax compliance gate.',
                    isMandatory: true,
                    controller: _taxIdController,
                  ),

                  const SizedBox(height: 12),

                  // SUBMIT BUTTON (>=48px TOUCH TARGET)
                  SizedBox(
                    width: double.infinity,
                    height: 48.0,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _submitForm,
                      icon: const Icon(Icons.send_rounded),
                      label: const Text(
                        'Validate & Submit Ingestion',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // DESIGN SYSTEM TOKEN METADATA CARD
            Text(
              'Form Design System Metadata',
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
                    _buildMetaRow('System Name', _tokens.systemName),
                    const Divider(),
                    _buildMetaRow('System Version', _tokens.systemVersion),
                    const Divider(),
                    _buildMetaRow(
                      'Component List',
                      _tokens.componentList.join(', '),
                    ),
                    const Divider(),
                    _buildMetaRow(
                      'Asterisk Symbol Token',
                      _tokens.tokenValues['asteriskSymbol'].toString(),
                    ),
                    const Divider(),
                    _buildMetaRow(
                      'Asterisk Color Token',
                      _tokens.tokenValues['asteriskColorHex'].toString(),
                    ),
                    const Divider(),
                    _buildMetaRow(
                      'Documentation Links',
                      _tokens.documentationLinks,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
