import 'package:flutter/material.dart';

typedef WidgetBuilderFromSchema =
    Widget Function(Map<String, dynamic> properties, BuildContext context);

/// Centralized Component Registry Dictionary mapping JSON component type strings to Flutter UI artifacts
class ComponentRegistry {
  static final Map<String, WidgetBuilderFromSchema> _registry = {
    'HeaderCard': (props, context) => _buildHeaderCard(props, context),
    'ActionVerbButton': (props, context) =>
        _buildActionVerbButton(props, context),
    'InfoBanner': (props, context) => _buildInfoBanner(props, context),
    'FormInputField': (props, context) => _buildFormInputField(props, context),
  };

  /// Returns the registered widget artifact for a given JSON component string
  static Widget buildComponent(
    String typeString,
    Map<String, dynamic> properties,
    BuildContext context,
  ) {
    final builder = _registry[typeString];
    if (builder != null) {
      return builder(properties, context);
    }

    // Fallback UI for unregistered component strings
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      color: Colors.amber.shade100,
      child: Text(
        'UNREGISTERED_COMPONENT: "$typeString"',
        style: TextStyle(
          color: Colors.amber.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Artifact 1: HeaderCard
  static Widget _buildHeaderCard(
    Map<String, dynamic> props,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return Card.filled(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              props['title'] ?? 'HEADER_CARD',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              props['subtitle'] ?? '',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (props['codeTag'] != null) ...[
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  props['codeTag'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Artifact 2: ActionVerbButton (with min 48dp touch target)
  static Widget _buildActionVerbButton(
    Map<String, dynamic> props,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    final String actionVerb = props['actionVerb'] ?? 'EXECUTE_ACTION';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
        child: SizedBox(
          width: double.infinity,
          height: 48.0,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('DYNAMIC ACTION EXECUTED: "$actionVerb"'),
                  backgroundColor: Colors.teal.shade800,
                ),
              );
            },
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(
              actionVerb,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Artifact 3: InfoBanner
  static Widget _buildInfoBanner(
    Map<String, dynamic> props,
    BuildContext context,
  ) {
    return Card.filled(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
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
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    props['title'] ?? 'Info Banner',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.green.shade900,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    props['message'] ?? '',
                    style: const TextStyle(fontSize: 11, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Artifact 4: FormInputField (with min 48dp touch target)
  static Widget _buildFormInputField(
    Map<String, dynamic> props,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            props['label'] ?? 'Form Input',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
          const SizedBox(height: 6.0),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: props['hint'] ?? '',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
