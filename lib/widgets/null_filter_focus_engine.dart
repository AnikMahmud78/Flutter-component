import 'package:flutter/material.dart';

class NullFilterFocusEngine extends StatefulWidget {
  final VoidCallback onValidSubmit;

  const NullFilterFocusEngine({
    super.key,
    required this.onValidSubmit,
  });

  @override
  State<NullFilterFocusEngine> createState() => _NullFilterFocusEngineState();
}

class _NullFilterFocusEngineState extends State<NullFilterFocusEngine> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodeField1 = FocusNode();
  final FocusNode _focusNodeField2 = FocusNode();
  
  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();

  String? _field1Error;
  String? _field2Error;

  void _validateAndShiftFocus() {
    setState(() {
      _field1Error = _field1Controller.text.trim().isEmpty ? 'This mandatory field cannot be null' : null;
      _field2Error = _field2Controller.text.trim().isEmpty ? 'Mandatory payload field required' : null;
    });

    if (_field1Error != null) {
      _focusNodeField1.requestFocus();
    } else if (_field2Error != null) {
      _focusNodeField2.requestFocus();
    } else {
      widget.onValidSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInputBlock(
            controller: _field1Controller,
            focusNode: _focusNodeField1,
            label: 'Ingress Contract ID',
            errorText: _field1Error,
            theme: theme,
          ),
          const SizedBox(height: 16.0),
          _buildInputBlock(
            controller: _field2Controller,
            focusNode: _focusNodeField2,
            label: 'End Document Payload Key',
            errorText: _field2Error,
            theme: theme,
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            height: 48.0,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48.0),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
              onPressed: _validateAndShiftFocus,
              icon: const Icon(Icons.filter_alt),
              label: const Text('EXECUTE NULL FILTER CHECK'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBlock({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String? errorText,
    required ThemeData theme,
  }) {
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48.0),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: hasError ? theme.colorScheme.error : theme.colorScheme.onSurface,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? theme.colorScheme.error : theme.colorScheme.outline,
                  width: hasError ? 2.0 : 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? theme.colorScheme.error : theme.colorScheme.primary,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
          child: hasError
              ? Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                  child: Text(
                    errorText,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
